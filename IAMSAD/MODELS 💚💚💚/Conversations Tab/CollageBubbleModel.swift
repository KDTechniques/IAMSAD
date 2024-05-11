//
//  CollageBubbleModel.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-11.
//

import SwiftUI

struct CollageBubbleModel {
    // MARK: - PROPERTIES
    let imageURLString: String
    let msgBubbleObj: MessageBubbleValues.MessageBubbleModel
    
    // MARK: - INITITLAIZER
    init(imageURLString: String, msgBubbleObj: MessageBubbleValues.MessageBubbleModel) {
        self.imageURLString = imageURLString
        self.msgBubbleObj = msgBubbleObj
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - getMockArray
    static func getMockArray() -> [Self] {
        var tempArray: [Self] = []
        
        for _ in 1...Int.random(in: 4...10) {
            let obj: Self = self.init(
                imageURLString: "https://picsum.photos/id/\(Int.random(in: 100...200))/500",
                msgBubbleObj: .getRandomMockObject()
            )
            
            tempArray.append(obj)
        }
        
        return tempArray
    }
}
