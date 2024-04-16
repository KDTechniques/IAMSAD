//
//  ReplyBubbleValues.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-16.
//

import SwiftUI

struct ReplyBubbleValues {
    static let stripWidth: CGFloat = 4
    static func mediaContentSize(_ mediaType: ConversationMediaTypes) -> CGFloat {
        mediaType == .sticker ? 80 : 80
    }
    static let innerBubbleFrameHeight: CGFloat = 90
    static let outerPadding: (Edge.Set, CGFloat) = ([.horizontal, .top], 5)
    static func leadingInnerPadding(_ mediaType: ConversationMediaTypes) -> CGFloat {
        mediaType == .sticker ? 10 : 15
    }
    static func userTypeToMediaTypeBadgePadding(_ mediaType: ConversationMediaTypes) -> CGFloat {
        mediaType == .sticker ? 5 : 8
    }
}
