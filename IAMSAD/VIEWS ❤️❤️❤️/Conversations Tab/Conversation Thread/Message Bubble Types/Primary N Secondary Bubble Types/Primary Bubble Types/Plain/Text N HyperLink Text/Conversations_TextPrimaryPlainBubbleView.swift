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
    
    let direction: BubbleShapeValues.Directions
    let isEdited: Bool
    let text: String
    let timestamp: String
    let status: ReadReceiptStatusTypes
    let shouldAnimate: Bool
    let height: CGFloat
    let withSecondaryContent: Bool
    
    // MARK: - INITIALIZER
    init(
        direction: BubbleShapeValues.Directions,
        isEdited: Bool = false,
        text: String,
        timestamp: String,
        status: ReadReceiptStatusTypes,
        shouldAnimate: Bool,
        height: CGFloat,
        withSecondaryContent: Bool
    ) {
        self.direction = direction
        self.isEdited = isEdited
        self.text = text
        self.timestamp = timestamp
        self.status = status
        self.shouldAnimate = shouldAnimate
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
        timestamp.widthOfHString(
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
            isEdited
            ? 2 - (direction == .left ? 1 : 0)
            : 1 - (direction == .left ? 1 : 0)
        )
    }
    
    var bubbleWidthNScreenToBubblePadding: CGFloat {
        (values.innerHPadding * 2) +
        textWidth +
        fromTextToSpacing +
        (isEdited ? editedWidth : 0) +
        timeStampWidth +
        editedToTimestampToReadReceiptSpacing +
        (direction == .right ? values.readReceiptShapesValues(dynamicTypeSize).size : 0) +
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
        .padding(.horizontal, values.innerHPadding)
        .padding(.vertical, values.innerVPadding)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_MessageBubbleView") {
    let values = MessageBubbleValues.self
    let direction: BubbleShapeValues.Directions = .random()
    
    return ScrollView(.vertical) {
        Conversations_MessageBubbleView(
            direction: direction,
            showPointer: .random()) {
                Conversations_TextPrimaryPlainBubbleView(
                    direction: direction,
                    isEdited: .random(),
                    text: "Hi there 👋👋👋",
                    timestamp: "12:12 PM",
                    status: .none,
                    shouldAnimate: .random(),
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
        direction: .random(),
        isEdited: .random(),
        text: "Hi there 👋👋👋",
        timestamp: "12:12 PM",
        status: .delivered,
        shouldAnimate: .random(),
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
        Conversations_BubbleEditedTimestampReadReceiptsView(
            isEdited: isEdited,
            timestamp: timestamp,
            status: status,
            shouldAnimate: shouldAnimate
        )
    }
}
