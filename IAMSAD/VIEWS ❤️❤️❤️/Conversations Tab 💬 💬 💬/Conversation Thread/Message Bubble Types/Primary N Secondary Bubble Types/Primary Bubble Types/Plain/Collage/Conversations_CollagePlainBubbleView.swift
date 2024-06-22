//
//  Conversations_CollagePlainBubbleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-01.
//

import SwiftUI
import SDWebImageSwiftUI

// To qualify as a collage, there must be at least 4 photos arranged in order.
struct Conversations_CollagePlainBubbleView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    let model: MessageBubbleValues.MessageBubbleModel
    let dataArray: [CollageBubbleModel]
    
    // MARK: - INIITIALIZER
    init(model: MessageBubbleValues.MessageBubbleModel, dataArray: [CollageBubbleModel]) {
        self.model = model
        self.dataArray = dataArray
    }
    
    // MARK: - PRIVATE PROPERTIES
    let values = MessageBubbleValues.self
    let bubbleShapeValues = BubbleShapeValues.self
    let blur: CGFloat = 4
    var imageCornerRadius: CGFloat { bubbleShapeValues.cornerRadius - values.secondaryOuterPadding.1 }
    var imageSize: CGFloat { (values.maxContentWidth - (values.secondaryOuterPadding.1 * 3)) / 2 }
    let circleSize: CGFloat = 54
    let stopRectangleSize: CGFloat = 10
    
    @State private var modifiedDataArray: [CollageBubbleModel.CollageBubbleCacheModel] = []
    var isAnyNonExist: Bool { modifiedDataArray.contains(where: { !$0.isExist }) }
    @State private var downloadStatus: DownloadStatusTypes = .none
    @State private var imageLoadOperationsArray: [SDWebImageOperation?] = []
    
    // MARK: - BODY
    var body: some View {
        Conversations_MessageBubbleView(model) {
            VStack(spacing: values.secondaryOuterPadding.1) {
                ForEach(0...1, id: \.self) { index1 in
                    HStack(spacing: values.secondaryOuterPadding.1) {
                        ForEach(0...1, id: \.self) { index2 in
                            let index: Int = (index1*2) + index2
                            
                            image(index)
                                .overlay { overlayCount(index) }
                                .overlay(alignment: .bottom) { bottomContent(index) }
                        }
                    }
                    
                }
            }
            .overlay {
                if isAnyNonExist {
                    Conversations_ExpandableInfoCapsuleProgressView(
                        isCompressed: progressCompressionHandler(),
                        totalSize: Utilities.formatFileSize(getDownloadableTotalSize()),
                        itemsCount: dataArray.count
                    ) { startDownloadInQueue() } cancelAction: { cancelAllDownloads() }
                }
            }
            .padding(values.secondaryOuterPadding.1)
            .padding(.top, model.isForwarded ? values.innerVPadding : 0)
        }
        .onAppear { cacheNFileExistenceChecker() }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_CollagePlainBubbleView") {
    ZStack {
        Color.conversationBackground.ignoresSafeArea()
        
        Image(.whatsappchatbackgroundimage)
            .resizable()
            .scaledToFill()
            .frame(width: screenWidth, height: screenHeight)
            .clipped()
            .opacity(0.3)
        
        Conversations_CollagePlainBubbleView(
            model: .getRandomMockObject(true),
            dataArray: CollageBubbleModel.getMockArray()
        )
    }
    .previewViewModifier
}

// MARK: - EXTENSIONS
extension Conversations_CollagePlainBubbleView {
    // MARK: - image
    @ViewBuilder
    private func image(_ index: Int) -> some View {
        var urlString: String {
            if modifiedDataArray.isEmpty {
                return dataArray[index].urlString
            } else {
                let obj: CollageBubbleModel.CollageBubbleCacheModel = modifiedDataArray[index]
                
                return obj.isExist ? obj.urlString : obj.placeholderImageURLString
            }
        }
        
        WebImage(
            url: .init(string: urlString),
            options: [.scaleDownLargeImages, .retryFailed, .progressiveLoad]
        )
        .resizable()
        .defaultBColorPlaceholder(values.anyImagePlaceholderColor)
        .scaledToFill()
        .frame(width: getImageSize(index), height: getImageSize(index))
        .blur(radius: getBlur(index))
        .frame(width: imageSize, height: imageSize)
        .clipShape(CustomRoundedRectangleShape(cornerRadius: imageCornerRadius))
    }
    
    // MARK: - overlayCount
    @ViewBuilder
    private func overlayCount(_ index: Int) -> some View {
        if index == 3, dataArray.count != 4 {
            Text("+\(dataArray.count-3)")
                .font(.largeTitle.weight(.medium))
                .foregroundStyle(.white)
        }
    }
    
    // MARK: - mediaIcon
    @ViewBuilder
    private func mediaIcon(_ index: Int) -> some View {
        if dataArray[index].mediaType == .video {
            Image(systemName: "video.fill")
                .font(values.timestampFont)
        }
    }
    
    // MARK: - bottomContent
    @ViewBuilder
    private func bottomContent(_ index: Int) -> some View {
        if index != 3 || dataArray.count == 4 {
            HStack {
                mediaIcon(index)
                Spacer()
                Conversations_BubbleEditedTimestampReadReceiptsView(
                    dataArray[index].msgBubbleObj,
                    color: .white
                )
            }
            .foregroundStyle(.white)
            .padding(.horizontal, values.innerHPadding/1.5)
            .padding(.bottom, values.innerVPadding/1.3)
        }
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - getBlur
    private func getBlur(_ index: Int) -> CGFloat {
        modifiedDataArray.contains(where: { !$0.isExist })
        ? blur
        : index == 3 && dataArray.count != 4 ? blur : 0
    }
    
    // MARK: - getImageSize
    private func getImageSize(_ index: Int) -> CGFloat {
        let expandSize: CGFloat = imageSize + blur*2
        
        return modifiedDataArray.contains(where: { !$0.isExist })
        ? expandSize
        : index == 3 && dataArray.count != 4 ? expandSize : imageSize
    }
    
    // MARK: - cacheNFileExistenceChecker
    private func cacheNFileExistenceChecker() {
        modifiedDataArray = dataArray.map { model in
            CollageBubbleModel.CollageBubbleCacheModel(
                mediaType: model.mediaType,
                urlType: .serverURL,
                isExist: Utilities.isCached(.init(string: model.urlString)),
                urlString: model.urlString,
                placeholderImageURLString: model.placeholderImageURLString,
                mediaSize: model.mediaSize
            )
        }
    }
    
    // MARK: - getDownloadableTotalSize
    private func getDownloadableTotalSize() -> UInt64 {
        modifiedDataArray
            .filter({ !$0.isExist })
            .map({ $0.mediaSize })
            .reduce(0, +)
    }
    
    // MARK: - expansionTriggerHandler
    private func progressCompressionHandler() -> Binding<Bool> {
        downloadStatus == .onProgress ? .constant(true) : .constant(false)
    }
    
    // MARK: - startDownloadInQueue
    private func startDownloadInQueue() {
        print("Download started in a queue.")
        setStatus(.onProgress)
        // start the downloading all the image files in a queue here...
    }
    
    // MARK: - cancelAllDownloads
    private func cancelAllDownloads() {
        print("All the downlods has been cancelled.")
        setStatus(.failure)
    }
    
    // MARK: - startImageDownload
    private func startImageDownload(urlString: String) {
        let imageLoadOperation: SDWebImageOperation? = SDWebImageManager.shared.loadImage(
            with: .init(string: urlString),
            options: [.retryFailed, .highPriority],
            progress: {_, _, _ in }, completed: { image, data, error, _, finished, imageURL in
                DispatchQueue.main.async {
                    if let _ = image, error == nil, finished {
                        // Save  the image data to local file directory and return the file directory url
                        
                        modifiedDataArray.removeAll(where: { $0.urlString == urlString })
                    }
                }
            }
        )
        
        imageLoadOperationsArray.append(imageLoadOperation)
        
    }
    
    // MARK: - setStatus
    private func setStatus(_ status: DownloadStatusTypes) {
        withAnimation(.smooth(duration: 1)) {
            downloadStatus = status
        }
    }
}
