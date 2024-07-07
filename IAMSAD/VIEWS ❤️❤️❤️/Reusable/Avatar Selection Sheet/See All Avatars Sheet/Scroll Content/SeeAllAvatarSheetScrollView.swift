//
//  SeeAllAvatarSheetScrollView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-07.
//

import SwiftUI

struct SeeAllAvatarSheetScrollView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var selectedCollection: AvatarCollectionModel?
    @Binding var showRowBackground: Bool
    
    // MARK: - INITIALIZER
    
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(AvatarCollectionTypes.avatarCollectionsArray) { item in
                    VStack(alignment: .leading) {
                        SeeAllAvatarSheetCollectionHeaderView(
                            collectionName: item.collectionName
                        )
                        
                        SeeAllAvatarSheetCollectionRowView(collectionName: item.collectionName)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    .padding(.bottom)
                    .overlay(alignment: .bottom) { Divider().padding(.horizontal) }
                    .background(Color(uiColor: setSelectedRowBackgroundColor(item: item)))
                    .onTapGesture { handleTapGestures(item: item) }
                    .onLongPressGesture(minimumDuration: .zero) {
                        handleTapGestures(item: item)
                    }
                }
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("SeeAllAvatarSheetScrollView") {
    @Previewable @State var selectedCollection: AvatarCollectionModel?
    @Previewable @State var showRowBackground: Bool = false
    
    Color.clear
        .sheet(isPresented: .constant(true)) {
            SeeAllAvatarSheetScrollView(
                selectedCollection: $selectedCollection,
                showRowBackground: $showRowBackground
            )
            .padding(.top)
        }
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension SeeAllAvatarSheetScrollView {
    // MARK: - FUNCTIONS
    
    // MARK: - checkSelectedCollection
    private func checkSelectedCollection(_ item: AvatarCollectionModel) -> Bool {
        selectedCollection == item && showRowBackground
    }
    
    // MARK: - setSelectedRowBackgroundColor
    private func setSelectedRowBackgroundColor(item: AvatarCollectionModel) -> UIColor {
        colorScheme == .dark
        ? (checkSelectedCollection(item)
           ? .systemGray4
           : .systemGray6
        )
        : (checkSelectedCollection(item)
           ? .systemGray4
           : .white
        )
    }
    
    // MARK: - handleTapGestures
    private func handleTapGestures(item: AvatarCollectionModel) {
        showRowBackground = true
        selectedCollection = item
    }
}
