//
//  AvatarCollectionModel.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-13.
//

import SwiftUI

struct AvatarCollectionModel: Identifiable, Equatable {
    // MARK: - PROPERTIES
    var id: String { collectionName.rawValue }
    let collectionName: AvatarCollectionTypes
    let avatarCount: Int
    let description: String
    let position: Alignment
    
    // MARK: - INITIAILIZER
    init(collectionName: AvatarCollectionTypes, avatarCount: Int, description: String, position: Alignment = .bottom) {
        self.collectionName = collectionName
        self.avatarCount    = avatarCount
        self.description    = description
        self.position       = position
    }
}

enum AvatarPositionTypes {
    case center, bottom
}

enum AvatarCollectionTypes: String, CaseIterable, Hashable {
    case featured       = "Featured"
    case superheroes    = "Super Heroes"
    case animals        = "Animals"
    case animalFaces    = "Animal Faces"
    case sports         = "Sports"
    case professions1   = "Professions 1"
    case professions2   = "Professions 2"
    case professions3   = "Professions 3"
    
    static let avatarCollectionsArray: [AvatarCollectionModel] = [
        .init(collectionName: .featured,
              avatarCount: 50,
              description: "Discover decent avatars curated for unique style and individuality."
             ),
        
            .init(
                collectionName: .superheroes,
                avatarCount: 40,
                description: "Transform your identity into a hero's journey with superhero inspired avatars."
            ),
        
            .init(
                collectionName: .animals,
                avatarCount: 20,
                description: "Unleash your untamed side and choose from our curated selection inspired by the beauty of the animal kingdom."
            ),
        
            .init(
                collectionName: .animalFaces,
                avatarCount: 21,
                description: "Express your wild side with these beautifully crafted cute animal faces.",
                position: .center
            ),
        
            .init(
                collectionName: .sports,
                avatarCount: 40,
                description: "Express your passion for sports with athletic themed avatars."
            ),
        
            .init(
                collectionName: .professions1,
                avatarCount: 20,
                description: "Embody the spirit of various professions with career inspired avatars."
            ),
        
            .init(
                collectionName: .professions2,
                avatarCount: 50,
                description: "Explore avatars representing diverse careers inspired by professions."
            ),
        
            .init(
                collectionName: .professions3,
                avatarCount: 50,
                description: "Showcase your ambition with avatars inspired by different professions."
            )
    ]
}
