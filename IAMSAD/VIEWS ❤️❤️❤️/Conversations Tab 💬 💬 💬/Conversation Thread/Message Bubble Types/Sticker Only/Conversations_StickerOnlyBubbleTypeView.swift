//
//  Conversations_StickerOnlyBubbleTypeView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-11.
//

import SwiftUI
import SDWebImageSwiftUI

// Sticker only bubble is a very unique media type bubble that differ from the reset.
// Because it doesn't belong to either Primary or Secondary bubble types.
// It's a standalone type.
struct Conversations_StickerOnlyBubbleTypeView: View {
    // MARK: - PROPERTIRS
    @Environment(\.colorScheme) private var colorScheme
    
    let url: URL?
    let timestamp: String
    let userType: MessageBubbleUserTypes
    
    // MARK: - PRIVATE PROPERTIES
    let values = MessageBubbleValues.self
    var alignment: Alignment { userType == .sender ? .trailing : .leading }
    let size: CGFloat = 138
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
                if Utilities.isCached(url) {
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
    let urlString: String = "https://www.icegif.com/wp-content/uploads/2023/03/icegif-1393.gif"
    
    return NavigationStack {
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
                    url: .init(string: urlString),
                    timestamp: "10:44 PM",
                    userType: .receiver
                )
                .padding(.top, screenHeight/2)
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
    
    // MARK: - placeholder
    @ViewBuilder
    private var placeholder: some View {
        var showProgress: Bool {
            switch status {
            case .onProgress:
                true
            case .none, .failure:
                false
            default:
                false
            }
        }
        
        Conversations_StickerPlaceholderShapeView()
            .overlay {
                StandardMediaCircularProgressView(value: progress, showProgress: showProgress) {
                    showProgress ? cancelImageDownload() : startImageDownload()
                }
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
