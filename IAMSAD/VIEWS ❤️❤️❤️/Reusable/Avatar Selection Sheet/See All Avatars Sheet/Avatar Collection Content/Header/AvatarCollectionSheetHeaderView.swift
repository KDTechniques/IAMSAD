//
//  AvatarCollectionSheetHeaderView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-07.
//

import SwiftUI

struct AvatarCollectionSheetHeaderView: View {
    // MARK: - PROPERTIES
    let item: AvatarCollectionModel
    
    // MARK: - INITIALIZER
    init(item: AvatarCollectionModel) {
        self.item = item
    }
    
    // MARK: -  BODY
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.collectionName.rawValue)
                .font(.largeTitle.bold())
            
            Text(item.description)
                .foregroundStyle(.secondary)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 50)
        .padding(.bottom, 18)
        .padding(.horizontal)
    }
}

// MARK: - PREVIEWS
#Preview("AvatarCollectionSheetHeaderView") {
    if let collection: AvatarCollectionModel = AvatarCollectionTypes.avatarCollectionsArray.first {
        AvatarCollectionSheetHeaderView(item: collection)
            .frame(maxHeight: .infinity, alignment: .top)
            .previewViewModifier
    }
}
