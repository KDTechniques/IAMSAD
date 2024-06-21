//
//  CollageBubbleModel.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-11.
//

import SwiftUI

struct CollageBubbleModel {
    // MARK: - PROPERTIES
    let mediaType: MediaTypes
    let urlString: String
    let placeholderImageURLString: String
    let mediaSize: UInt64
    let msgBubbleObj: MessageBubbleValues.MessageBubbleModel
    
    enum MediaTypes: CaseIterable { case photo, video }
    enum URLTypes { case serverURL, fileDirectoryURL }
    
    struct CollageBubbleCacheModel {
        let mediaType: MediaTypes
        let urlType: URLTypes
        let isExist: Bool
        let urlString: String
        let placeholderImageURLString: String
        var mediaSize: UInt64
    }
    
    // MARK: - INITITLAIZER
    init(
        mediaType: MediaTypes,
        urlString: String,
        placeholderImageURLString: String,
        mediaSize: UInt64,
        msgBubbleObj: MessageBubbleValues.MessageBubbleModel
    ) {
        self.mediaType = mediaType
        self.urlString = urlString
        self.placeholderImageURLString = placeholderImageURLString
        self.mediaSize = mediaSize
        self.msgBubbleObj = msgBubbleObj
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - getMockArray
    static func getMockArray() -> [Self] {
        var tempArray: [Self] = []
        
        for _ in 1...Int.random(in: 4...10) {
            let randomNumber: Int = .random(in: 400...504)
            let obj: Self = self.init(
                mediaType: .random(),
                urlString: "https://picsum.photos/id/\(randomNumber)/500",
                placeholderImageURLString: "https://picsum.photos/id/\(randomNumber)/50",
                mediaSize: .random(in: 50000...100000),
                msgBubbleObj: .getRandomMockObject()
            )
            
            tempArray.append(obj)
        }
        
        return tempArray
    }
}
