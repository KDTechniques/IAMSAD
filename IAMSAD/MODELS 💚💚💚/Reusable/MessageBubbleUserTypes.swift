//
//  MessageBubbleUserTypes.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-10.
//

import Foundation

enum MessageBubbleUserTypes {
    case receiver, sender
    
    static func random() -> Self {
        Bool.random() ? .receiver : .sender
    }
}
