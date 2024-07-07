//
//  AvatarModel.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-28.
//

import SwiftUI

struct AvatarModel: Identifiable, Equatable {
    // MARK: - PROPERTIES
    var id: String { imageName }
    let imageName: String
    let collection: AvatarCollectionTypes
    let position: Alignment
    private(set) var backgroundColor: Color = .white
    
    // MARK: - INITIALIZER
    init(
        imageName: String,
        collection: AvatarCollectionTypes,
        position: Alignment
    ) {
        self.imageName = imageName
        self.collection = collection
        self.position = position
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: updateBackgroundColor
    mutating func updateBackgroundColor(_ color: Color) {
        backgroundColor = color
    }
}
