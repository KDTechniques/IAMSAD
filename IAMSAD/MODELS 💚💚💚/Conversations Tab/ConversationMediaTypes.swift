//
//  ConversationMediaTypes.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-12.
//

import Foundation

enum ConversationMediaTypes: CaseIterable {
    case text
    case photo
    case sticker // Sticker gifs and GIFs are two different things even though their extensions are same.
    case gif // GIFs are from GIFPHY, or from a link.
    case video
    case voiceRecord
    case audio
    case linkWithPreview // Only used for secondary bubble reply type where it shows the link and small preview next to each other.
    case linkTextOnly
    case socialMediaInfo // Shows a preview of the url content.
    case collage
}
