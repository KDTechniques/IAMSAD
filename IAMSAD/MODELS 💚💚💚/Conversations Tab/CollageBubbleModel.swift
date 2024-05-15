//
//  CollageBubbleModel.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-11.
//

import SwiftUI

struct CollageBubbleModel {
    // MARK: - PROPERTIES
    let type: Types
    let urlString: String
    let placeholderImageURLString: String
    let msgBubbleObj: MessageBubbleValues.MessageBubbleModel
    
    enum Types: CaseIterable { case photo, video }
    
    // MARK: - INITITLAIZER
    init(type: Types, urlString: String, placeholderImageURLString: String, msgBubbleObj: MessageBubbleValues.MessageBubbleModel) {
        self.type = type
        self.urlString = urlString
        self.placeholderImageURLString = placeholderImageURLString
        self.msgBubbleObj = msgBubbleObj
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - getMockArray
    static func getMockArray() -> [Self] {
        var tempArray: [Self] = []
        
        for _ in 1...Int.random(in: 4...10) {
            let randomNumber: Int = .random(in: 100...200)
            let obj: Self = self.init(
                type: .random(),
                urlString: "https://picsum.photos/id/\(randomNumber)/500",
                placeholderImageURLString: "https://picsum.photos/id/\(randomNumber)/10",
                msgBubbleObj: .getRandomMockObject()
            )
            
            tempArray.append(obj)
        }
        
        return tempArray
    }
}
