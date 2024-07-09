//
//  AvatarCollectionSheetView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-07.
//

import SwiftUI

struct AvatarCollectionSheetView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    @Environment(AvatarSheetVM.self) private var avatarSheetVM
    
    @Binding var showRowBackground: Bool
    let item: AvatarCollectionModel
    
    // MARK: - INITIALIZER
    init(showRowBackground: Binding<Bool>, item: AvatarCollectionModel) {
        _showRowBackground = showRowBackground
        self.item = item
    }
    
    // MARK: - PRIVATE PROPERTIES
    let avatarColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    let scrollContentTopPadding: CGFloat = 15
    @State private var showDivider: Bool = false
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 0) {
            AvatarCollectionSheetHeaderView(item: item)
            HidableDividerView(showDivider: showDivider)
            
            ScrollView(.vertical, showsIndicators: false) {
                AvatarCollectionListView(collection: item.collectionName)
                    .padding(.horizontal)
                    .padding(.top, scrollContentTopPadding)
                    .padding(.bottom, 100)
            }
            .onScrollGeometryChange(for: Bool.self) { geo in
                geo.contentOffset.y > scrollContentTopPadding
            } action: { showDivider = $1 }
        }
        .presentationDragIndicator(.visible)
        .overlay(alignment: .bottom) { AvatarCollectionSheetFooterView() }
        .onAppear { handleOnAppear() }
    }
}

// MARK: - PREVIEWS
#Preview("AvatarCollectionSheetView") {
    @Previewable @State var showBackground: Bool = false
    let array: [AvatarCollectionModel] = AvatarCollectionTypes.avatarCollectionsArray
    let maxIndex: Int = array.count-1
    let collection: AvatarCollectionModel = array[Int.random(in: 0...maxIndex)]
    
    Color.clear
        .sheet(isPresented: .constant(true)) {
            AvatarCollectionSheetView(
                showRowBackground: $showBackground,
                item: collection
            )
        }
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension AvatarCollectionSheetView {
    // MARK: - FUNCTIONS
    
    // MARK: - handleOnAppear
    private func handleOnAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            showRowBackground = false
        }
    }
}
