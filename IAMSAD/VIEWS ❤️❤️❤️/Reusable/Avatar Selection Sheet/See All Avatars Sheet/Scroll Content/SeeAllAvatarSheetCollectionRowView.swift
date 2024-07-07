//
//  SeeAllAvatarSheetCollectionRowView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-07.
//

import SwiftUI

struct SeeAllAvatarSheetCollectionRowView: View {
    // MARK: - PROPERTIES
    let avatar: Avatar = .shared
    
    let collectionName: AvatarCollectionTypes
    
    // MARK: - INITILIZER
    init(collectionName: AvatarCollectionTypes) {
        self.collectionName = collectionName
    }
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 10) {
            let avatarsArray: [AvatarModel] = Array(
                avatar.publicAvatarsDictionary[collectionName]?.prefix(6) ?? []
            )
            
            ForEach(avatarsArray) {
                CustomAvatarView(
                    avatar: $0,
                    color: Color(
                        hue: Double.random(in: 0...1),
                        saturation: 0.1,
                        brightness: 1
                    ),
                    withBorder: true
                )
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("SeeAllAvatarSheetCollectionRowView") {
    SeeAllAvatarSheetCollectionRowView(collectionName: .random())
        .previewViewModifier
}
