//
//  MessageBubbleValues.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-14.
//

import SwiftUI

struct MessageBubbleValues {
    static let bubbleShapeValues = BubbleShapeValues.self
    static func readReceiptShapesValues(_ dynamicTypeSize: DynamicTypeSize) -> ReadReceiptShapesValues {
        ReadReceiptShapesValues(dynamicTypeSize: dynamicTypeSize)
    }
    static let screenToBubblePadding: CGFloat = 10
    static let maxWidthLimitationPadding: CGFloat = 85
    static let innerHPadding: CGFloat = 12
    static let innerVPadding: CGFloat = 8
    static var innerVPaddingTimestampOnly: CGFloat { innerVPadding - 0.5 }
    static let timestampToReadReceiptPadding: CGFloat = 3
    static let timestampFont: Font = .caption
    static let bubbleToBubbleVPadding: CGFloat = 3
    static let stickerFrameSize: CGFloat = 138
    static let mediaTypeFont: Font = .footnote
    static func mediaTypeFontHeight(_ dynamicTypeSize: DynamicTypeSize) -> CGFloat {
        "".heightOfHString(usingFont: .from(mediaTypeFont), dynamicTypeSize)
    }
    static let mediaTypeIconToTextHPadding: CGFloat = 4
    
    static func getDirection(_ by: MessageBubbleUserTypes ) -> BubbleShapeValues.Directions {
        by == .sender ? .right : .left
    }
}
