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
    let blur: CGFloat = 5
    var imageCornerRadius: CGFloat { bubbleShapeValues.cornerRadius - values.secondaryOuterPadding.1 }
    var imageSize: CGFloat { (values.maxContentWidth - (values.secondaryOuterPadding.1 * 3)) / 2 }
    let circleSize: CGFloat = 54
    let stopRectangleSize: CGFloat = 10
    
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
                StandardMediaCircularProgressView(value: 0.5, showProgress: .random()) {
                    
                }
                
                collageInfoCapsule
            }
            .padding(values.secondaryOuterPadding.1)
            .padding(.top, model.isForwarded ? values.innerVPadding : 0)
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_CollagePlainBubbleView") {
    Conversations_CollagePlainBubbleView(
        model: .getRandomMockObject(true),
        dataArray: CollageBubbleModel.getMockArray()
    )
    .previewViewModifier
}

// MARK: - EXTENSIONS
extension Conversations_CollagePlainBubbleView {
    // MARK: - image
    private func image(_ index: Int) -> some View {
        WebImage(
            url: .init(string: dataArray[index].urlString),
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
        if dataArray[index].type == .video {
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
    
    // MARK: - collageInfoCapsule
    private var collageInfoCapsule: some View {
        HStack(spacing: 20) {
            StandardMediaCircularProgress_ArrowDownView()
            
            VStack(spacing: 0) {
                Text("669 KB")
                    .fontWeight(.medium)
                
                Text("\(dataArray.count) items")
                    .fontWeight(.light)
            }
        }
        .font(.footnote)
        .foregroundStyle(.arrowDown)
        .frame(height: StandardMediaCircularProgressValues.frameSize)
        .padding(.horizontal, 23.5)
        .offset(x: -4)
        .standardCircularProgressBackgroundViewModifier(colorScheme)
        .clipShape(Capsule())
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - getBlur
    private func getBlur(_ index: Int) -> CGFloat {
        index == 3 && dataArray.count != 4 ? blur : 0
    }
    
    // MARK: - getImageSize
    private func getImageSize(_ index: Int) -> CGFloat {
        index == 3 && dataArray.count != 4 ? imageSize + blur*2 : imageSize
    }
}
