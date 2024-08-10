//
//  AvatarCollectionListView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-07.
//

import SwiftUI

struct AvatarCollectionListView: View {
    // MARK: - PROPERTIES
    @Environment(AvatarSheetVM.self) private var vm
    @State private var vm$: AvatarSheetVM = .shared
    
    let collection: AvatarCollectionTypes
    
    // MARK: - PRIVATE PROPERTIES
    let avatar: Avatar = .shared
    let numberOfColumns: Int = 4
    var columns: [GridItem] { Array(repeating: .init(.flexible()), count: numberOfColumns) }
    
    // MARK: - INITIALIZER
    init(collection: AvatarCollectionTypes) {
        self.collection = collection
    }
    
    // MARK: - BODY
    var body: some View {
        if let avatarsArray: [AvatarModel] = avatar.publicAvatarsDictionary[collection] {
            let totalItems: Int = avatarsArray.count
            
            // Remove one of the closure content based on performance
            if false { // remove the following if manual grid contain flickers when scrolling
                VStack(alignment: .leading) {
                    ForEach(getVerticalRange(totalItems: totalItems), id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach(getHorizontalRange(), id: \.self) { column in
                                let cellIndex: Int = getCellIndex(row: row, column: column) - 1
                                
                                if cellIndex < totalItems {
                                    CustomSelectableAvatarView(
                                        selectedAvatar: $vm$.selectedAvatar,
                                        dynamicColor: $vm$.selectedBackgroundColor,
                                        avatar: avatarsArray[cellIndex],
                                        staticColor: Color(
                                            hue: vm.selectedBackgroundColor.hue,
                                            saturation: vm.selectedBackgroundColor.saturation,
                                            brightness: vm.selectedBackgroundColor.brightness
                                        ),
                                        isAutoColorOn: true
                                    )
                                } else { Color.clear }
                            }
                        }
                    }
                }
            } else { // remove the following if Lazy VGrid flickers when scrolling
                LazyVGrid(columns: columns) {
                    ForEach(avatarsArray) {
                        CustomSelectableAvatarView(
                            selectedAvatar: $vm$.selectedAvatar,
                            dynamicColor: $vm$.selectedBackgroundColor,
                            avatar: $0,
                            staticColor: Color(
                                hue: vm.selectedBackgroundColor.hue,
                                saturation: vm.selectedBackgroundColor.saturation,
                                brightness: vm.selectedBackgroundColor.brightness
                            ),
                            isAutoColorOn: true
                        )
                    }
                }
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("AvatarCollectionListView") {
    ScrollView(.vertical, showsIndicators: false) {
        AvatarCollectionListView(collection: .professions3)
            .padding()
    }
    .previewViewModifier
}

// MARK: - EXTENSIONS
extension AvatarCollectionListView {
    // MARK: - getCellIndex
    private func getCellIndex(row: Int, column: Int) -> Int {
        row * numberOfColumns + column + 1 - 1
    }
    
    // MARK: - getVerticalRange
    private func getVerticalRange(totalItems: Int) -> Range<Int> {
        0..<(totalItems / numberOfColumns) + (totalItems % numberOfColumns > 0 ? 1 : 0)
    }
    
    // MARK: - getHorizontalRange
    private func getHorizontalRange() -> ClosedRange<Int> { 1...numberOfColumns }
}
