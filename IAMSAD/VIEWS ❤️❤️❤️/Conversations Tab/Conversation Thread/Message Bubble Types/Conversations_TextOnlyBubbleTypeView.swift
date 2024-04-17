//
//  Conversations_TextOnlyBubbleTypeView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-10.
//

import SwiftUI

struct Conversations_TextOnlyBubbleTypeView<T: View>: View {
    // MARK: - PROPERTIES
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    let text: String
    let timestamp: String
    let status: ReadReceiptStatusTypes
    let userType: MessageBubbleUserTypes
    let showPointer: Bool
    let shouldAnimate: Bool
    let withContent: Bool
    let content: (CGFloat) -> T
    
    @State private var isExceededLineLimit: Bool = false
    @State private var isReadMore: Bool = false
    @State private var height: CGFloat = 0
    let values = MessageBubbleValues.self
    let singleLineHSpacing: CGFloat = 12
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
    var approxLineLimit: Int {
        let text: String = "👨🏻‍💻"
        let textHeight: CGFloat = text.heightOfHString(
            usingFont: .preferredFont(forTextStyle: .body),
            dynamicTypeSize
        )
        let accuracyValue: Int = 4
        
        return Int(screenHeight/textHeight) - accuracyValue
    }
    @State private var bubbleWidth: CGFloat = 0
    
    // MARK: - INITILAIZER
    init(
        text: String,
        timestamp: String,
        status: ReadReceiptStatusTypes,
        userType: MessageBubbleUserTypes,
        showPointer: Bool,
        shouldAnimate: Bool,
        withContent: Bool = false,
        @ViewBuilder content: @escaping (CGFloat) -> T = { _ in EmptyView() }
    ) {
        self.text = text
        self.timestamp = timestamp
        self.status = status
        self.userType = userType
        self.showPointer = showPointer
        self.shouldAnimate = shouldAnimate
        self.withContent = withContent
        self.content = content
    }
    
    // MARK: - BODY
    var body: some View {
        Conversations_MessageBubbleView(
            direction: values.getDirection(userType),
            showPointer: showPointer
        ) {
            VStack(alignment: .leading, spacing: 0) {
                content(bubbleWidth)
                
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
                .geometryReaderDimensionViewModifier($bubbleWidth, dimension: .width)
            }
            .overlay(alignment: .bottomTrailing) {
                if withContent {
                    timestampNReadReceipts
                        .padding(.trailing, values.innerHPadding)
                        .padding(.bottom, values.innerVPadding)
                }
            }
            .geometryReaderDimensionViewModifier($height, dimension: .height)
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_TextOnlyBubbleTypeView") {
    ScrollView(.vertical) {
        LazyVStack {
            Conversations_TextOnlyBubbleTypeView(
                text: "Hello there 👋👋👋",
                timestamp: "06:12 PM",
                status: .random(),
                userType: .sender,
                showPointer: true,
                shouldAnimate: .random()
            ) { _ in }
        }
    }
}

// MARK: - EXTENSIONS
extension Conversations_TextOnlyBubbleTypeView {
    // MARK: textOnly
    private var textOnly: some View {
        Text(text)
    }
    
    // MARK: - singleLineBubble
    private var singleLineBubble: some View {
        HStack(alignment: .bottom, spacing: singleLineHSpacing) {
            textOnly
            timestampNReadReceipts
                .opacity(withContent ? 0 : 1)
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
                .opacity(withContent ? 0 : 1)
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
                    .opacity(withContent ? 0 : 1)
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
