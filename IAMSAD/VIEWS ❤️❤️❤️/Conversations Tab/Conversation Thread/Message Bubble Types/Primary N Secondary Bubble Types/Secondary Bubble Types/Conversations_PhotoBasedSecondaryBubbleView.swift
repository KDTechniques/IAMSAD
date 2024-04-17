//
//  Conversations_PhotoBasedSecondaryBubbleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-17.
//

import SwiftUI

struct Conversations_PhotoBasedSecondaryBubbleView: View {
    // MARK: - PROPERTIES
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    let messageBubbleWidth: CGFloat
    let stripColor: Color
    let userName: String
    
    // MARK: - INITIALIZER
    init(
        messageBubbleWidth: CGFloat,
        stripColor: Color,
        userName: String
    ) {
        self.messageBubbleWidth = messageBubbleWidth
        self.stripColor = stripColor
        self.userName = userName
    }
    
    // MARK: - PRIVATE PROPERTIES
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
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: replyBubbleValues.userTypeTextHPadding) {
            strip
            verticalContainer
            spacer
            photo
        }
        .frame(height: replyBubbleValues.innerBubbleFrameHeight)
        .setMaxWidthViewModifier(shouldExpand: shouldExpand, messageBubbleWidth: messageBubbleWidth)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_SecondaryBubbleView") {
    Conversations_SecondaryBubbleView(primaryMediaType: .sticker, secondaryMediaType: .photo)
        .previewViewModifier
}

#Preview("Conversations_PhotoBasedSecondaryBubbleView") {
    Conversations_PhotoBasedSecondaryBubbleView(
        messageBubbleWidth: 100,
        stripColor: .debug,
        userName: "Wifey ❤️😘"
    )
    .previewViewModifier
}

// MARK: - EXTENSIONS
extension Conversations_PhotoBasedSecondaryBubbleView {
    // MARK: - strip
    private var strip: some View {
        stripColor
            .frame(width: replyBubbleValues.stripWidth)
    }
    
    // MARK: - verticalContainer
    private var verticalContainer: some View {
        VStack(alignment: .leading, spacing: replyBubbleValues.userTypeToMediaTypeBadgePadding(.photo)) {
            Text(userName)
                .font(replyBubbleValues.userTypeFont)
                .lineLimit(1)
            
            Conversations_PhotoBadgeView()
        }
        .padding(.trailing, shouldExpand ? -replyBubbleValues.userTypeTextHPadding : 0)
    }
    
    // MARK: - spacer
    @ViewBuilder
    private var spacer: some View {
        if shouldExpand {
            Spacer()
        }
    }
    
    // MARK: - photo
    private var photo: some View {
        Image(.follower1)
            .resizable()
            .scaledToFill()
            .frame(width: replyBubbleValues.mediaContentSize)
            .clipped()
    }
}

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
