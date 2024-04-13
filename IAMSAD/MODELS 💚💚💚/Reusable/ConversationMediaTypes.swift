//
//  ConversationMediaTypes.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-12.
//

import Foundation

enum ConversationMediaTypes: String, CaseIterable {
    case text
    case photo = "Photo"
    case sticker = "Sticker" // Sticker gifs and GIFs are two different things even though their extensions are same.
    case gif = "GIF" // GIFs are from GIFPHY, or from a link
    case video = "Video"
}
