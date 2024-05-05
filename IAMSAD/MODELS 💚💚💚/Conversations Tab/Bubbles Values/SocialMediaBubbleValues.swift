//
//  SocialMediaBubbleValues.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-28.
//

import SwiftUI

struct SocialMediaBubbleValues {
    // MARK: - PROPERTIES
    static private let values = MessageBubbleValues.self
    static let titleTextFont: Font = .footnote.weight(.semibold)
    static let descriptionTextFont: Font = .caption
    static let domainTextFont: Font = .caption2
    static let titleToDescriptionSpacing: CGFloat = 4
    static let descriptionToDomainSpacing: CGFloat = 8
    static let textVContainerVerticalPadding: CGFloat = 7
    static let titleTextOpacity: CGFloat = 0.75
    
    // MARK: - FUNCTIONS
    static private func getTitleTextHeight(_ dynamicTypeSize: DynamicTypeSize) -> CGFloat {
        "".heightOfHString(usingFont: .from(titleTextFont), dynamicTypeSize)
    }
    
    static private func getDescriptionTextHeight(_ dynamicTypeSize: DynamicTypeSize) -> CGFloat {
        "".heightOfHString(usingFont: .from(descriptionTextFont), dynamicTypeSize)
    }
    
    static private func getDomainTextHeight(_ dynamicTypeSize: DynamicTypeSize) -> CGFloat {
        "".heightOfHString(usingFont: .from(domainTextFont), dynamicTypeSize)
    }
    
    static func getTextBasedVContainerFullHeight(_ dynamicTypeSize: DynamicTypeSize) -> CGFloat {
        textVContainerVerticalPadding +
        getTitleTextHeight(dynamicTypeSize) +
        titleToDescriptionSpacing +
        getDescriptionTextHeight(dynamicTypeSize) +
        descriptionToDomainSpacing +
        getDomainTextHeight(dynamicTypeSize) +
        textVContainerVerticalPadding
    }
    
    
    static func getSocialMediaCoverHeight(_ mediaType: SocialMediaTypes) -> CGFloat {
        switch mediaType {
        case .facebook:
            0
        case .instagram:
            0
        case .youtube:
            0
        case .tiktok:
            values.secondaryBubbleValues.innerBubbleFrameHeight + 244
        }
    }
}
