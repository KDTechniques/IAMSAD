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
    var imageCornerRadius: CGFloat { bubbleShapeValues.cornerRadius - values.secondaryOuterPadding.1 }
    var imageSize: CGFloat { (values.maxContentWidth - (values.secondaryOuterPadding.1 * 3)) / 2 }
    
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
                                .overlay(alignment: .bottomTrailing) { bottomTrailingContent(index) }
                        }
                    }
                    
                }
            }
            .padding(values.secondaryOuterPadding.1)
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
            url: .init(string: dataArray[index].imageURLString),
            options: [.scaleDownLargeImages, .retryFailed, .progressiveLoad]
        )
        .resizable()
        .defaultBColorPlaceholder(values.anyImagePlaceholderColor)
        .scaledToFill()
        .frame(width: imageSize, height: imageSize)
        .blur(radius: index == 3 ? 5 : 0)
        .clipShape(CustomRoundedRectangleShape(cornerRadius: imageCornerRadius))
    }
    
    // MARK: - overlayCount
    @ViewBuilder
    private func overlayCount(_ index: Int) -> some View {
        if index == 3 {
            Text("+\(dataArray.count-1)")
                .font(.largeTitle.weight(.medium))
                .foregroundStyle(.white)
        }
    }
    
    // MARK: - bottomTrailingContent
    @ViewBuilder
    private func bottomTrailingContent(_ index: Int) -> some View {
        if index != 3 {
            Conversations_BubbleEditedTimestampReadReceiptsView(
                dataArray[index].msgBubbleObj,
                color: .white
            )
            .foregroundStyle(.white)
            .padding(.trailing, values.innerHPadding/1.5)
            .padding(.bottom, values.innerVPadding/1.3)
        }
    }
}
