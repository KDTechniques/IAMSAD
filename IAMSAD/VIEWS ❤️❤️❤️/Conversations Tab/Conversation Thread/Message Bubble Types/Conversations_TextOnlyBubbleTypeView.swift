//
//  Conversations_TextOnlyBubbleTypeView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-10.
//

import SwiftUI

struct Conversations_TextOnlyBubbleTypeView: View {
    // MARK: - PROPERTIES
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    let text: String
    let timestamp: String
    let userType: MessageBubbleUserTypes
    let showPointer: Bool
    
    @State private var isExceededLineLimit: Bool = false
    @State private var isReadMore: Bool = false
    @State private var height: CGFloat = 0
    let values = MessageBubbleValues.self
    let innerHPadding: CGFloat = 10
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
    var bubbleWidth: CGFloat {
        (innerHPadding * 2) +
        textWidth +
        singleLineHSpacing +
        timeStampWidth +
        values.bubbleShapeValues.externalWidth +
        values.screenToBubblePadding
    }
    var conditionToBeSingleLineBubble: Bool {
        let safeValue: CGFloat = 10
        let bubbleMaxWidth: CGFloat = screenWidth -
        values.maxWidthLimitationPadding - safeValue
        
        return bubbleWidth < bubbleMaxWidth
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
    
    // MARK: - INITILAIZER
    init(
        text: String,
        timestamp: String,
        userType: MessageBubbleUserTypes,
        showPointer: Bool
    ) {
        self.text = text
        self.timestamp = timestamp
        self.userType = userType
        self.showPointer = showPointer
    }
    
    // MARK: - BODY
    var body: some View {
        Conversations_MessageBubbleView(
            direction: values.getDirection(userType),
            showPointer: showPointer
        ) {
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
            .padding(.horizontal, innerHPadding)
            .padding(.vertical, 8)
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
                userType: .sender,
                showPointer: true
            )
        }
    }
}

// MARK: - EXTENSIONS
extension Conversations_TextOnlyBubbleTypeView {
    // MARK: - singleLineBubble
    private var singleLineBubble: some View {
        HStack(alignment: .bottom, spacing: singleLineHSpacing) {
            Text(text)
            Conversations_BubbleTimeStampView(timestamp)
        }
        .onAppear {
            print("singleLineBubble")
        }
    }
    
    // MARK: - multiLineBubble
    private var multiLineBubble: some View {
        VStack(alignment: .trailing, spacing: 6) {
            Text(text)
            Conversations_BubbleTimeStampView(timestamp)
        }
        .onAppear {
            print("multiLineBubble")
        }
    }
    
    // MARK: - readMoreBubble
    private var readMoreBubble: some View {
        VStack(spacing: 6) {
            Text(text)
                .lineLimit(approxLineLimit)
            
            HStack(alignment: .bottom) {
                Conversations_ReadMoreButtonView { isReadMore = true }
                Spacer()
                Conversations_BubbleTimeStampView(timestamp)
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
}
