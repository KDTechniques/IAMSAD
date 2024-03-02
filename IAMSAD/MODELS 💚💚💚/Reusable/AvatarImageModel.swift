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
    
    // MARK: - INITIALIZER
    init(imageName: String, collection: AvatarCollectionTypes, position: Alignment) {
        self.imageName = imageName
        self.collection = collection
        self.position = position
    }
}

final class Avatar: ObservableObject {
    // MARK: - PROPERTIES
    static let shared: Avatar = .init()
    var publicAvatarsArray: [AvatarModel] = []
    
    // MARK: - INITIALIZER
    private init() { initializePublicAvatarArray() }
    
    // MARK: - FUNCTIONS
    
    // MARK: - getPosition
    private func getPosition(_ collection: AvatarCollectionTypes) -> Alignment {
        AvatarCollectionTypes
            .avatarCollectionsArray
            .first(where: { $0.collectionName == collection })?
            .position ?? .bottom
    }
    
    // MARK: - initializePublicAvatarArray
    private func initializePublicAvatarArray()  {
        var tempArray: [AvatarModel] = []
        
        for item in AvatarCollectionTypes.avatarCollectionsArray {
            for index in 1...item.avatarCount {
                tempArray.append(.init(
                    imageName: item.collectionName.rawValue+"_"+index.description,
                    collection: item.collectionName,
                    position: getPosition(item.collectionName)
                ))
            }
        }
        
        publicAvatarsArray = tempArray
    }
}
