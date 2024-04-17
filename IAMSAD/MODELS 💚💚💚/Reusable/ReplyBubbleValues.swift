//
//  ReplyBubbleValues.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-16.
//

import SwiftUI

struct ReplyBubbleValues {
    static let userTypeFont: Font = .subheadline.weight(.semibold)
    static let stripWidth: CGFloat = 4
    static let mediaContentSize: CGFloat = 52 // width & height for stickers, and only width for other types
    static let innerBubbleFrameHeight: CGFloat = 61
    static let outerPadding: (Edge.Set, CGFloat) = ([.horizontal, .top], 4)
    static let userTypeTextHPadding: CGFloat = 9
    static func userTypeToMediaTypeBadgePadding(_ mediaType: ConversationMediaTypes) -> CGFloat {
        mediaType == .sticker ? 5 : 4
    }
}
