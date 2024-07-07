//
//  SeeAllAvatarSheetCollectionHeaderView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-07.
//

import SwiftUI

struct SeeAllAvatarSheetCollectionHeaderView: View {
    // MARK: - PROPERTIES
    @Environment(AvatarSheetVM.self) private var vm
    
    let collectionName: AvatarCollectionTypes
    
    // MARK: - INITIALIZER
    init(collectionName: AvatarCollectionTypes) {
        self.collectionName = collectionName
    }
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Text(collectionName.rawValue)
                .font(.headline)
            
            Spacer()
            
            Image(systemName: "checkmark")
                .font(.subheadline)
                .opacity(vm.selectedAvatar?.collection == collectionName ? 1 : 0)
        }
    }
}

// MARK: - PREVIEWS
#Preview("SeeAllAvatarSheetCollectionHeaderView") {
    SeeAllAvatarSheetCollectionHeaderView(collectionName: .random())
        .previewViewModifier
}
