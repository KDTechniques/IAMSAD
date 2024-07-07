//
//  Avatar.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-18.
//

import SwiftUI
struct Avatar {
    // MARK: - PROPERTIES
    static let shared: Avatar = .init()
    private(set) var publicAvatarsDictionary: [AvatarCollectionTypes: [AvatarModel]] = [:]
    
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
    mutating private func initializePublicAvatarArray()  {
        var tempDictionary: [AvatarCollectionTypes: [AvatarModel]] = [:]
        
        for item in AvatarCollectionTypes.avatarCollectionsArray {
            var tempArray: [AvatarModel] = []
            
            for index in 1...item.avatarCount {
                tempArray.append(.init(
                    imageName: item.collectionName.rawValue+"_"+index.description,
                    collection: item.collectionName,
                    position: getPosition(item.collectionName)
                ))
            }
            
            tempDictionary[item.collectionName] = tempArray
        }
        
        publicAvatarsDictionary = tempDictionary
    }
}
