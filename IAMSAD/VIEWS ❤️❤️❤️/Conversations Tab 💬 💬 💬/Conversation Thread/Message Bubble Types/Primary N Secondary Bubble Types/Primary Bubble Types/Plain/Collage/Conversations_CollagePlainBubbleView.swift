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
    
    @State private var modifiedDataArray: [CollageBubbleModel.CollageBubbleCacheModel] = []
    var isAnyNonExist: Bool { modifiedDataArray.contains(where: { !$0.isExist }) }
    @State private var downloadStatus: DownloadStatusTypes = .none
    @State private var imageLoadOperationsArray: [SDWebImageOperation?] = []
    
    // MARK: - BODY
    var body: some View {
        Conversations_MessageBubbleView(model) {
            Conversations_CollageImagesContainerView(
                dataArray: dataArray,
                modifiedDataArray: modifiedDataArray
            )
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
    
    // MARK: - FUNCTIONS
    
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
