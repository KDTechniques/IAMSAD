//
//  Conversations_CollageImagesContainerView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-06-25.
//

import SwiftUI
import SDWebImageSwiftUI

struct Conversations_CollageImagesContainerView: View {
    // MARK: - PROPERTIES
    let dataArray: [CollageBubbleModel]
    let modifiedDataArray: [CollageBubbleModel.CollageBubbleCacheModel]
    
    // MARK: - INITIALIZER
    init(
        dataArray: [CollageBubbleModel],
        modifiedDataArray: [CollageBubbleModel.CollageBubbleCacheModel]
    ) {
        self.dataArray = dataArray
        self.modifiedDataArray = modifiedDataArray
    }
    
    // MARK: - PRIVATE PROPERTIES
    let values = MessageBubbleValues.self
    let bubbleShapeValues = BubbleShapeValues.self
    let blur: CGFloat = 4
    var imageCornerRadius: CGFloat { bubbleShapeValues.cornerRadius - values.secondaryOuterPadding.1 }
    var imageSize: CGFloat { (values.maxContentWidth - (values.secondaryOuterPadding.1 * 3)) / 2 }
    let circleSize: CGFloat = 54
    let stopRectangleSize: CGFloat = 10
    
    
    // MARK: - BODY
    var body: some View {
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
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_CollageImagesContainerView") {
    Conversations_CollagePlainBubbleView(
        model: .getRandomMockObject(true),
        dataArray: CollageBubbleModel.getMockArray()
    )
    .previewViewModifier
}

extension Conversations_CollageImagesContainerView {
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
}
