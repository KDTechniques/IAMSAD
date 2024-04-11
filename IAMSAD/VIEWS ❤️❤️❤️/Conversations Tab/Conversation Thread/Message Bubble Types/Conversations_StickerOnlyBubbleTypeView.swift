//
//  Conversations_StickerOnlyBubbleTypeView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-11.
//

import SwiftUI
import SDWebImageSwiftUI

struct Conversations_StickerOnlyBubbleTypeView: View {
    // MARK: - PROPERTIRS
    @Environment(\.colorScheme) private var colorScheme
    
    let url: URL?
    let timestamp: String
    let userType: MessageBubbleUserTypes
    
    let values = MessageBubbleValues.self
    var alignment: Alignment {
        userType == .sender ? .trailing : .leading
    }
    let size: CGFloat = 138
    
    // MARK: - INITIALIZER
    init(url: URL?, timestamp: String, userType: MessageBubbleUserTypes) {
        self.url = url
        self.timestamp = timestamp
        self.userType = userType
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: alignment.horizontal, spacing: values.bubbleToBubbleVPadding) {
            WebImage(url: url, options: [.scaleDownLargeImages, .retryFailed, .highPriority])
                .resizable()
                .defaultBColorPlaceholder()
                .scaledToFit()
                .frame(width: size, height: size)
                .background(.yellow.opacity(0.5))
                .clipped()
            
            Conversations_BubbleTimeStampView(timestamp)
                .padding(.horizontal, values.innerHPadding)
                .padding(.vertical, values.innerVPaddingTimestampOnly)
                .background(userType == .sender ? .bubbleSender : .bubbleReceiver)
                .clipShape(CustomRoundedRectangleShape(cornerRadius: values.bubbleShapeValues.timestampOnlyCornerRadius))
                .conversationsBubbleShadowViewModifier(colorScheme) {
                    AnyShape(CustomRoundedRectangleShape(cornerRadius: values.bubbleShapeValues.timestampOnlyCornerRadius))
                }
        }
        .frame(maxWidth: .infinity, alignment: alignment)
        .padding([userType == .sender ? .trailing : .leading], values.screenToBubblePadding)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_StickerOnlyBubbleTypeView") {
    ZStack {
        Color.conversationBackground
            .ignoresSafeArea()
        
        Conversations_StickerOnlyBubbleTypeView(
            url: .init(string: "https://media2.giphy.com/media/3o6gE51uXycrKW6D84/200w.gif"),
            timestamp: "10:44 PM",
            userType: .random()
        )
    }
}
