//
//  Conversations_TextBasedPrimaryBubbleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-17.
//

import SwiftUI

struct Conversations_TextBasedPrimaryBubbleView: View {
    // MARK: - PROPERTIES
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    let isEdited: Bool
    let text: String
    let timestamp: String
    let status: ReadReceiptStatusTypes
    let shouldAnimate: Bool
    let height: CGFloat
    let withSecondaryContent: Bool
    
    // MARK: - INITIALIZER
    init(
        isEdited: Bool = false,
        text: String,
        timestamp: String,
        status: ReadReceiptStatusTypes,
        shouldAnimate: Bool,
        height: CGFloat,
        withSecondaryContent: Bool
    ) {
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
            usingFont: .from(values.editedFont),
            dynamicTypeSize
        ) + values.editedToTimestampTrailingPadding
    }
    
    var bubbleWidthNScreenToBubblePadding: CGFloat {
        (values.innerHPadding * 2) +
        textWidth +
        fromTextToSpacing +
        (isEdited ? editedWidth : 0) +
        timeStampWidth +
        (values.editedToTimestampToReadReceiptSpacing * (isEdited ? 2 : 1)) +
        values.readReceiptShapesValues(dynamicTypeSize).size +
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
#Preview("Conversations_TextBasedPrimaryBubbleView") {
    Conversations_TextBasedPrimaryBubbleView(
        text: "Hi there 👋👋👋",
        timestamp: "12:12 PM",
        status: .delivered,
        shouldAnimate: false,
        height: screenWidth,
        withSecondaryContent: false
    )
    .background(Color.debug.opacity(0.5))
    .previewViewModifier
}

#Preview("Conversations_MessageBubbleView") {
    let values = MessageBubbleValues.self
    
    return Conversations_MessageBubbleView(
        direction: .right,
        showPointer: true) {
            Conversations_TextBasedPrimaryBubbleView(
                isEdited: .random(),
                text: "Check out this website: https://www.example.com and also this one: https://www.anotherexample.com",
                timestamp: "12:12 PM",
                status: .seen,
                shouldAnimate: true,
                height: screenWidth,
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
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension Conversations_TextBasedPrimaryBubbleView{
    // MARK: textOnly
    @ViewBuilder
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
        VStack(spacing: 6) {
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
