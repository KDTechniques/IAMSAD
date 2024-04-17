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
    
    let text: String
    let timestamp: String
    let status: ReadReceiptStatusTypes
    let shouldAnimate: Bool
    let height: CGFloat
    let withSecondaryContent: Bool
    
    // MARK: - INITIALIZER
    init(
        text: String,
        timestamp: String,
        status: ReadReceiptStatusTypes,
        shouldAnimate: Bool,
        height: CGFloat,
        withSecondaryContent: Bool
    ) {
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
    let singleLineHSpacing: CGFloat = 12
    
    var approxLineLimit: Int {
        let text: String = "👨🏻‍💻"
        let textHeight: CGFloat = text.heightOfHString(
            usingFont: .preferredFont(forTextStyle: .body),
            dynamicTypeSize
        )
        let accuracyValue: Int = 4
        
        return Int(screenHeight/textHeight) - accuracyValue
    }
    
    var textWidth: CGFloat {
        text.widthOfHString(
            usingFont: .preferredFont(forTextStyle: .body),
            dynamicTypeSize
        )
    }
    
    var timeStampWidth: CGFloat {
        timestamp.widthOfHString(
            usingFont: .preferredFont(forTextStyle: .caption1),
            dynamicTypeSize
        )
    }
    
    var bubbleWidthNScreenToBubblePadding: CGFloat {
        (values.innerHPadding * 2) +
        textWidth +
        singleLineHSpacing +
        timeStampWidth +
        values.timestampToReadReceiptPadding +
        values.readReceiptShapesValues(dynamicTypeSize).size +
        values.bubbleShapeValues.pointerWidth +
        values.screenToBubblePadding
    }
    
    var conditionToBeSingleLineBubble: Bool {
        let safeValue: CGFloat = 10
        let bubbleMaxWidth: CGFloat = screenWidth -
        values.maxWidthLimitationPadding - safeValue
        
        return bubbleWidthNScreenToBubblePadding < bubbleMaxWidth
    }
    
    // MARK: - BODY
    var body: some View {
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
    .background(Color.debug)
    .previewViewModifier
}

// MARK: - EXTENSIONS
extension Conversations_TextBasedPrimaryBubbleView{
    // MARK: textOnly
    private var textOnly: some View {
        Text(text)
    }
    
    // MARK: - singleLineBubble
    private var singleLineBubble: some View {
        HStack(alignment: .bottom, spacing: singleLineHSpacing) {
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
        Conversations_BubbleTimestampReadReceiptsView(
            timestamp: timestamp,
            status: status,
            shouldAnimate: shouldAnimate
        )
    }
}
