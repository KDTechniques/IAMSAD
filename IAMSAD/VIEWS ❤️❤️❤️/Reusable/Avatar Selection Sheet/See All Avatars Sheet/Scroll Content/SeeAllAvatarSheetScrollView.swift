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
    
    // MARK: - PRIVATE PROPERTIES
    let avatarCollectionsArray: [AvatarCollectionModel] = AvatarCollectionTypes.avatarCollectionsArray
    private var lastCollectionID: String? { avatarCollectionsArray.last?.id }
    
    // MARK: - INITIALIZER
    init(selectedCollection: Binding<AvatarCollectionModel?>, showRowBackground: Binding<Bool>) {
        _selectedCollection = selectedCollection
        _showRowBackground = showRowBackground
    }
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(avatarCollectionsArray) { item in
                    VStack(alignment: .leading) {
                        SeeAllAvatarSheetCollectionHeaderView(
                            collectionName: item.collectionName
                        )
                        
                        SeeAllAvatarSheetCollectionRowView(collectionName: item.collectionName)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    .padding(.bottom)
                    .overlay(alignment: .bottom) { bottomOverlayDivider(id: item.id) }
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
    // MARK: - bottomOverlayDivider
    @ViewBuilder
    private func bottomOverlayDivider(id: String) -> some View {
        let currentNPreviousIDs: (cID: String, pID: String) = getSelectedNPreviousID()
        
        Divider()
            .padding(.horizontal)
            .opacity(id == (lastCollectionID ?? "") ? 0 : 1)
            .opacity(currentNPreviousIDs.cID == id ? 0 : 1)
            .opacity(currentNPreviousIDs.pID == id ? 0 : 1)
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - getSelectedNPreviousID
    private func getSelectedNPreviousID() -> (cID: String, pID: String) {
        guard showRowBackground,
              let selectedCollectionID: String = selectedCollection?.id,
              let index: Int = avatarCollectionsArray.firstIndex(where: { $0.id == selectedCollectionID }) else {
            return ("", "")
        }
        
        var previousCollectionID: String {
            let previousIndex: Int = index-1
            
            return previousIndex >= 0 ? avatarCollectionsArray[previousIndex].id : ""
        }
        
        return (selectedCollectionID, previousCollectionID)
    }
    
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
