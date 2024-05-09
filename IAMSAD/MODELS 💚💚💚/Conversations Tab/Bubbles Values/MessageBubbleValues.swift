//
//  MessageBubbleValues.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-14.
//

import SwiftUI

struct MessageBubbleValues {
    // MARK: - PROPERTIES
    static let bubbleShapeValues = BubbleShapeValues.self
    static let secondaryBubbleValues = SecondaryBubbleValues.self
    static let socialMediaBubbleValues = SocialMediaBubbleValues.self
    
    static let screenToBubblePadding: CGFloat = 10
    static let maxWidthLimitationPadding: CGFloat = 85
    static let innerHPadding: CGFloat = 12
    static let innerVPadding: CGFloat = 8
    static var innerVPaddingTimestampOnly: CGFloat { innerVPadding - 0.5 }
    static let editedToTimestampToReadReceiptSpacing: CGFloat = 3
    static let editedToTimestampTrailingPadding: CGFloat = 2
    static let textFont: Font = .body
    static let timestampFont: Font = .caption
    static let bottomTrailingContentBottomPadding: CGFloat = -2
    static let bubbleToBubbleVPadding: CGFloat = 3
    static let stickerFrameSize: CGFloat = 138
    static let mediaTypeFont: Font = .footnote
    static let mediaTypeIconToTextHPadding: CGFloat = 4
    static let anyImagePlaceholderColor: Color = .primary.opacity(0.1)
    static let secondaryOuterPadding: (Edge.Set, CGFloat) = ([.horizontal, .top], 4)
    
    static var maxContentWidth: CGFloat {
        screenWidth -
        maxWidthLimitationPadding -
        bubbleShapeValues.pointerWidth -
        screenToBubblePadding
    }
    
    // MARK: - FUNCTIONS
    static func getDirection(_ by: MessageBubbleUserTypes ) -> BubbleShapeValues.Directions {
        by == .sender ? .right : .left
    }
    
    static func mediaTypeFontHeight(_ dynamicTypeSize: DynamicTypeSize) -> CGFloat {
        "".heightOfHString(usingFont: .from(mediaTypeFont), dynamicTypeSize)
    }
    
    static func readReceiptShapesValues(_ dynamicTypeSize: DynamicTypeSize) -> ReadReceiptShapesValues {
        ReadReceiptShapesValues(dynamicTypeSize: dynamicTypeSize)
    }
    
    // MARK: - MessageBubbleModel
    struct MessageBubbleModel {
        // MARK: - PROPERTIES
        let direction: BubbleShapeValues.Directions
        let showPointer: Bool
        let isForwarded: Bool
        let isEdited: Bool
        let timestamp: String
        let status: ReadReceiptStatusTypes
        let shouldAnimate: Bool
        
        // MARK: - INITIALIZER
        init(
            direction: BubbleShapeValues.Directions,
            showPointer: Bool,
            isForwarded: Bool = false,
            isEdited: Bool = false,
            timestamp: String,
            status: ReadReceiptStatusTypes,
            shouldAnimate: Bool = false
        ) {
            self.direction = direction
            self.showPointer = showPointer
            self.isEdited = isEdited
            self.isForwarded = isForwarded
            self.timestamp = timestamp
            self.status = status
            self.shouldAnimate = shouldAnimate
        }
        
        // MARK: - FUNCTIONS
        
        // MARK: - getRandomMockObject
        static func getRandomMockObject(_ withForwarded: Bool = false, _ withEdited: Bool = false) -> Self {
            .init(
                direction: .random(),
                showPointer: .random(),
                isForwarded: withForwarded ? .random() : false,
                isEdited: withEdited ? .random() : false,
                timestamp: getRandomTimestamp(),
                status: .random(),
                shouldAnimate: .random()
            )
        }
        
        // MARK: - getRandomTimestamp
        private static func getRandomTimestamp() -> String {
            enum Types: String, CaseIterable { case am, pm }
            
            let type: String = Types.random().rawValue.uppercased()
            let hour: Int = .random(in: 1...12)
            var minute: String {
                let value: Int = Int.random(in: 00...59)
                
                return value < 10 ? "0\(value)" : value.description
            }
            
            return "\(hour):\(minute) \(type)"
        }
    }
}
