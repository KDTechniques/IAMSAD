//
//  Conversations_PhotoBasedReplyBubbleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-17.
//

import SwiftUI

struct Conversations_PhotoBasedReplyBubbleView: View {
    // MARK: - PROPERTIES
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    let messageBubbleWidth: CGFloat
    let stripColor: Color
    let mediaType: ConversationMediaTypes
    let userName: String
    
    let values = MessageBubbleValues.self
    var replyBubbleValues: ReplyBubbleValues.Type { values.replyBubbleValues }
    var outerPadding: (Edge.Set, CGFloat) { replyBubbleValues.outerPadding }
    var replyBubbleWidth: CGFloat {
        (outerPadding.1 * 2) +
        replyBubbleValues.stripWidth +
        (replyBubbleValues.userTypeTextHPadding * 2) +
        userName.widthOfHString(usingFont: .from(replyBubbleValues.userTypeFont), dynamicTypeSize) +
        replyBubbleValues.mediaContentSize
    }
    var shouldExpand: Bool { replyBubbleWidth < messageBubbleWidth }
    
    // MARK: - INITIALIZER
    
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: replyBubbleValues.userTypeTextHPadding) {
            stripColor
                .frame(width: replyBubbleValues.stripWidth)
            
            VStack(alignment: .leading, spacing: replyBubbleValues.userTypeToMediaTypeBadgePadding(mediaType)) {
                Text(userName)
                    .font(replyBubbleValues.userTypeFont)
                    .lineLimit(1)
                
                Conversations_PhotoBadgeView()
            }
            .padding(.trailing, shouldExpand ? -replyBubbleValues.userTypeTextHPadding : 0)
            
            if shouldExpand {
                Spacer()
            }
            
            Image(.follower1)
                .resizable()
                .scaledToFill()
                .frame(width: replyBubbleValues.mediaContentSize)
                .clipped()
            
        }
        .frame(height: replyBubbleValues.innerBubbleFrameHeight)
        .setMaxWidthViewModifier(shouldExpand: shouldExpand, messageBubbleWidth: messageBubbleWidth)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_PhotoBasedReplyBubbleView") {
    Conversations_ReplyBubbleTypeView(mediaType: .photo)
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension View {
    // MARK: - setMaxWidthViewModifier
    @ViewBuilder
    fileprivate func setMaxWidthViewModifier(shouldExpand: Bool, messageBubbleWidth: CGFloat) -> some View {
        if shouldExpand {
            self
                .frame(maxWidth: messageBubbleWidth)
        } else {
            self
        }
    }
}
