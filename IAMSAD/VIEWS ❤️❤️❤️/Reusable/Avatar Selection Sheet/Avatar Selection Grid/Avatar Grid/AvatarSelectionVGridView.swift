//
//  AvatarSelectionVGridView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-06.
//

import SwiftUI

struct AvatarSelectionVGridView: View {
    // MARK: - PROPERTIES
    @Environment(AvatarSheetVM.self) private var vm
    @State private var vm$: AvatarSheetVM = .shared
    
    let collectionName: AvatarCollectionTypes
    
    // MARK: - PRIVATE PROPERTIES
    let avatar: Avatar = .shared
    var avatarsArray: [AvatarModel] {
        Array(avatar.publicAvatarsDictionary[collectionName]?.prefix(20) ?? [])
    }
    
    // MARK: - INITIALIZER
    init(collectionName: AvatarCollectionTypes) {
        self.collectionName = collectionName
    }
    
    // MARK: - BODY
    var body: some View {
        LazyVGrid(columns: vm.avatarColumns) {
            ForEach(avatarsArray) {
                CustomSelectableAvatarView(
                    selectedAvatar: $vm$.selectedAvatar,
                    avatar: $0,
                    staticColor: Color(
                        hue: vm.selectedBackgroundColor.hue,
                        saturation: vm.selectedBackgroundColor.saturation,
                        brightness: vm.selectedBackgroundColor.brightness
                    )
                )
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("AvatarSelectionVGridView") {
    AvatarSelectionVGridView(collectionName: .random())
        .previewViewModifier
}
