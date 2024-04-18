//
//  Conversations_StickerOnlyBubbleTypeView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-11.
//

import SwiftUI
import SDWebImageSwiftUI
import SwiftUIIntrospect

struct Conversations_StickerOnlyBubbleTypeView: View {
    // MARK: - PROPERTIRS
    @Environment(\.colorScheme) private var colorScheme
    
    let url: URL?
    let timestamp: String
    let userType: MessageBubbleUserTypes
    
    let values = MessageBubbleValues.self
    var alignment: Alignment {
        userType == .sender ? .trailing : .leading
    }
    let size: CGFloat = 138
    let circleSize: CGFloat = 54
    let arrowDownSize: CGFloat = 14
    let stopRectangleSize: CGFloat = 10
    @State private var imageLoadOperation: SDWebImageOperation? = nil
    @State private var progress: CGFloat = 0
    @State private var status: DownloadStatusTypes = .none
    
    // MARK: - INITIALIZER
    init(url: URL?, timestamp: String, userType: MessageBubbleUserTypes) {
        self.url = url
        self.timestamp = timestamp
        self.userType = userType
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: alignment.horizontal, spacing: values.bubbleToBubbleVPadding) {
            ZStack {
                if isAlreadyCached(url) {
                    image
                } else {
                    placeholder
                }
            }
            .frame(width: size, height: size)
            
            timestampBubble
        }
        .frame(maxWidth: .infinity, alignment: alignment)
        .padding([userType == .sender ? .trailing : .leading], values.screenToBubblePadding)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_StickerOnlyBubbleTypeView") {
    NavigationStack {
        ZStack {
            Color.conversationBackground
                .ignoresSafeArea()
            
            Image(.whatsappchatbackgroundimage)
                .resizable()
                .scaledToFill()
                .frame(width: screenWidth, height: screenHeight)
                .clipped()
                .ignoresSafeArea()
                .opacity(0.25)
            
            ScrollView(.vertical) {
                Conversations_StickerOnlyBubbleTypeView(
                    url: .init(string: "https://cdn.pixabay.com/animation/2022/10/11/09/05/09-05-26-529_512.gif"),
                    timestamp: "10:44 PM",
                    userType: .receiver
                )
                .padding(.top, screenHeight/2)
            }
            .introspect(.scrollView, on: .iOS(.v17)) { scrollview in
                print("Is Tracking: \(scrollview.isTracking)")
            }
        }
    }
    .previewViewModifier
}

// MARK: - EXTENSIONS
@MainActor
extension Conversations_StickerOnlyBubbleTypeView {
    // MARK: - image
    private var image: some View {
        AnimatedImage(url: url, options: [.scaleDownLargeImages, .retryFailed, .progressiveLoad])
            .placeholder {
                Conversations_StickerPlaceholderShapeView()
                    .overlay { ProgressView().tint(.secondary) }
                    .frame(width: size, height: size)
            }
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipped()
    }
    
    // MARK: - circle
    private var circle: some View {
        Circle()
            .fill(.arrowDownCircle)
    }
    
    // MARK: - circularProgress
    private var circularProgress: some View {
        Group {
            Circle()
                .trim(from: 0, to: progress)
                .stroke(.arrowDown, style: .init(lineWidth: 2, lineCap: .round))
                .padding(3)
                .rotationEffect(.degrees(-90))
            
            RoundedRectangle(cornerRadius: 2)
                .fill(.arrowDown)
                .frame(width: stopRectangleSize, height: stopRectangleSize)
        }
        .onTapGesture { cancelImageDownload() }
    }
    
    // MARK: - arrowDown
    private var arrowDown: some View {
        Image(systemName: "arrow.down")
            .resizable()
            .scaledToFit()
            .frame(width: arrowDownSize, height: arrowDownSize)
            .fontWeight(.semibold)
            .foregroundStyle(.arrowDown)
            .onTapGesture { startImageDownload() }
    }
    
    // MARK: - placeholder
    private var placeholder: some View {
        Conversations_StickerPlaceholderShapeView()
            .overlay {
                circle
                    .overlay {
                        if status == .onProgress {
                            circularProgress
                        } else if status == .none || status == .failure {
                            arrowDown
                        }
                    }
                    .frame(width: circleSize, height: circleSize)
            }
    }
    
    // MARK: - timestampBubble
    private var timestampBubble: some View {
        Conversations_BubbleTimeStampView(timestamp)
            .padding(.horizontal, values.innerHPadding)
            .padding(.vertical, values.innerVPaddingTimestampOnly)
            .background(userType == .sender ? .bubbleSender : .bubbleReceiver)
            .clipShape(CustomRoundedRectangleShape(cornerRadius: values.bubbleShapeValues.timestampOnlyCornerRadius))
            .conversationsBubbleShadowViewModifier(colorScheme) {
                AnyShape(CustomRoundedRectangleShape(cornerRadius: values.bubbleShapeValues.timestampOnlyCornerRadius))
            }
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - isAlreadyCached
    private func isAlreadyCached(_ url: URL?) -> Bool {
        let key: String? = SDWebImageManager.shared.cacheKey(for: url)
        return SDImageCache.shared.diskImageDataExists(withKey: key)
    }
    
    // MARK: - startImageDownload
    private func startImageDownload() {
        imageLoadOperation = SDWebImageManager.shared.loadImage(
            with: url,
            options: [.scaleDownLargeImages, .retryFailed, .highPriority],
            progress: { receivedSize, totalSize, _ in
                DispatchQueue.main.async {
                    setStatus(.onProgress)
                    withAnimation(.smooth) {
                        progress = CGFloat(receivedSize) / CGFloat(totalSize)
                    }
                }
            }, completed: { image, _, error, _, finished, imageURL in
                DispatchQueue.main.async {
                    if let _ = image, error == nil, finished {
                        setStatus(.success)
                    } else {
                        setStatus(.failure)
                    }
                }
            }
        )
    }
    
    // MARK: - cancelImageDownload
    private func cancelImageDownload() {
        imageLoadOperation?.cancel()
        print("❌❌❌❌")
    }
    
    // MARK: - setStatus
    private func setStatus(_ status: DownloadStatusTypes) {
        withAnimation(.smooth) {
            self.status = status
        }
    }
}
