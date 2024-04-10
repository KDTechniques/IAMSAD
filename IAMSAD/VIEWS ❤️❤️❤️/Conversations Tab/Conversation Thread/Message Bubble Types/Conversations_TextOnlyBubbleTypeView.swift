//
//  Conversations_TextOnlyBubbleTypeView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-10.
//

import SwiftUI

struct Conversations_TextOnlyBubbleTypeView: View {
    // MARK: - PROPERTIES
    let text: String
    let timestamp: String
    let userType: MessageBubbleUserTypes
    let showPointer: Bool
    
    @State private var isExceededLineLimit: Bool = false
    @State private var isReadMore: Bool = false
    @State private var height: CGFloat = 0
    @State private var minX: CGFloat = 0
    let values: MessageBubbleValues = .init()
    var condition: Bool {
        let value1: CGFloat = 10
        let value2: CGFloat = values.maxWidthLimitationPadding + value1
        
        return userType == .sender
        ? minX > value2
        : minX < value2
    }
    var approxLineLimit: Int {
        let text: String = "👨🏻‍💻"
        let textHeight: CGFloat = text.heightOfHString(
            usingFont: .preferredFont(forTextStyle: .body)
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
                        if condition {
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
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .geometryReaderDimensionViewModifier($height, dimension: .height)
            .geometryReaderFrameViewModifier(rect: .minX, $minX)
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
                userType:.sender,
                showPointer: true
            )
        }
    }
}

// MARK: - EXTENSIONS
extension Conversations_TextOnlyBubbleTypeView {
    // MARK: - multiLineBubble
    private var multiLineBubble: some View {
        VStack(alignment: .trailing, spacing: 6) {
            Text(text)
            Conversations_BubbleTimeStampView(timestamp)
        }
    }
    
    // MARK: - expandedBubble
    private var expandedBubble: some View {
        multiLineBubble.frame(maxWidth: .infinity)
    }
    
    // MARK: - singleLineBubble
    private var singleLineBubble: some View {
        HStack(alignment: .bottom, spacing: 12) {
            Text(text)
            Conversations_BubbleTimeStampView(timestamp)
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
    }
}
