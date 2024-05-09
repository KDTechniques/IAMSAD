//
//  Conversations_TextPrimaryPlainBubbleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-17.
//

import SwiftUI

struct Conversations_TextPrimaryPlainBubbleView: View {
    // MARK: - PROPERTIES
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    let model: MessageBubbleValues.MessageBubbleModel
    let text: String
    let height: CGFloat
    let withSecondaryContent: Bool
    
    // MARK: - INITIALIZER
    init(
        model: MessageBubbleValues.MessageBubbleModel,
        text: String,
        height: CGFloat,
        withSecondaryContent: Bool
    ) {
        self.model = model
        self.text = text
        self.height = height
        self.withSecondaryContent = withSecondaryContent
    }
    
    // MARK: - PRIVATE PROPERTIES
    @State private var isReadMore: Bool = false
    
    let values = MessageBubbleValues.self
    let fromTextToSpacing: CGFloat = 12
    
    var approxLineLimit: Int {
        let text: String = "👨🏻‍💻"
        let textHeight: CGFloat = text.heightOfHString(
            usingFont:  .from(values.textFont),
            dynamicTypeSize
        )
        let accuracyValue: Int = 4
        
        return Int(screenHeight/textHeight) - accuracyValue
    }
    
    var textWidth: CGFloat {
        text.widthOfHString(
            usingFont: .from(values.textFont),
            dynamicTypeSize
        )
    }
    
    var timeStampWidth: CGFloat {
        model.timestamp.widthOfHString(
            usingFont: .from(values.timestampFont),
            dynamicTypeSize
        )
    }
    
    var editedWidth: CGFloat {
        "Edited".widthOfHString(
            usingFont: .from(values.timestampFont),
            dynamicTypeSize
        ) + values.editedToTimestampTrailingPadding
    }
    
    var editedToTimestampToReadReceiptSpacing: CGFloat {
        values.editedToTimestampToReadReceiptSpacing *
        (
            model.isEdited
            ? 2 - (model.direction == .left ? 1 : 0)
            : 1 - (model.direction == .left ? 1 : 0)
        )
    }
    
    var bubbleWidthNScreenToBubblePadding: CGFloat {
        (values.innerHPadding * 2) +
        textWidth +
        fromTextToSpacing +
        (model.isEdited ? editedWidth : 0) +
        timeStampWidth +
        editedToTimestampToReadReceiptSpacing +
        (model.direction == .right ? values.readReceiptShapesValues(dynamicTypeSize).size : 0) +
        values.bubbleShapeValues.pointerWidth +
        values.screenToBubblePadding
    }
    
    var conditionToBeSingleLineBubble: Bool {
        let bubbleMaxWidth: CGFloat = screenWidth - values.maxWidthLimitationPadding
        
        return bubbleWidthNScreenToBubblePadding < bubbleMaxWidth
    }
    
    // MARK: - BODY
    var body: some View {
        Group {
            if !isReadMore {
                if height < screenHeight {
                    if conditionToBeSingleLineBubble {
                        singleLineBubble
                    } else {
                        multiLineBubble
                    }
                } else {
                    readMoreBubble
                }
            } else {
                expandedBubble
            }
        }
        .messageBubbleContentDefaultPadding
        .forwardedPaddingViewModifier(model.isForwarded)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_MessageBubbleView") {
    let values = MessageBubbleValues.self
    let obj: MessageBubbleValues.MessageBubbleModel = .getRandomMockObject(true, true)
    
    return ScrollView(.vertical) {
        Conversations_MessageBubbleView(obj) {
            Conversations_TextPrimaryPlainBubbleView(
                model: obj,
                text: "Hi there 👋👋👋",
                height: 0,
                withSecondaryContent: false
            )
        }
        .overlay {
            Rectangle()
                .fill(.red)
                .frame(width: 1)
                .frame(width: screenWidth, alignment:  .leading)
                .offset(x: values.maxWidthLimitationPadding)
                .opacity(0)
        }
    }
    .background {
        Color.conversationBackground
            .ignoresSafeArea()
    }
    .previewViewModifier
}

#Preview("Conversations_TextPrimaryPlainBubbleView") {
    Conversations_TextPrimaryPlainBubbleView(
        model: .getRandomMockObject(true, true),
        text: "Hi there 👋👋👋",
        height: 0,
        withSecondaryContent: false
    )
    .background(Color.debug.opacity(0.5))
    .previewViewModifier
}

// MARK: - EXTENSIONS
extension Conversations_TextPrimaryPlainBubbleView {
    // MARK: textOnly
    private var textOnly: some View {
        Utilities.getUnderlinedHyperlinkText(text)
    }
    
    // MARK: - singleLineBubble
    private var singleLineBubble: some View {
        HStack(alignment: .bottom, spacing: fromTextToSpacing) {
            textOnly
            timestampNReadReceipts
                .opacity(withSecondaryContent ? 0 : 1)
        }
        .onAppear {
            print("singleLineBubble")
        }
    }
    
    // MARK: - multiLineBubble
    private var multiLineBubble: some View {
        VStack(alignment: .trailing, spacing: 6) {
            textOnly
            timestampNReadReceipts
                .opacity(withSecondaryContent ? 0 : 1)
        }
        .onAppear {
            print("multiLineBubble")
        }
    }
    
    // MARK: - readMoreBubble
    private var readMoreBubble: some View {
        VStack(alignment: .leading, spacing: 6) {
            textOnly
                .lineLimit(approxLineLimit)
            
            HStack(alignment: .bottom) {
                Conversations_ReadMoreButtonView { isReadMore = true }
                Spacer()
                timestampNReadReceipts
                    .opacity(withSecondaryContent ? 0 : 1)
            }
        }
        .onAppear {
            print("readMoreBubble")
        }
    }
    
    // MARK: - expandedBubble
    private var expandedBubble: some View {
        multiLineBubble.frame(maxWidth: .infinity)
            .onAppear {
                print("expandedBubble")
            }
    }
    
    // MARK: - timestampNReadReceipts
    private var timestampNReadReceipts: some View {
        Conversations_BubbleEditedTimestampReadReceiptsView(model)
    }
}
