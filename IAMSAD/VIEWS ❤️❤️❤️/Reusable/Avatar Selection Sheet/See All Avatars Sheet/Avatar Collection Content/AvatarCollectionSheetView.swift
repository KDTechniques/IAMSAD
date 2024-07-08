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
    
    // MARK: - PRIVATE PROPERTIES
    @State private var minY: CGFloat = 0
    let avatarColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    @State private var footerHeight: CGFloat = 0
    let scrollContentTopPadding: CGFloat = 15
    var scrollContentBottomPadding: CGFloat {
        let extraPadding: CGFloat = 10
        return footerHeight + extraPadding
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 0) {
            AvatarCollectionSheetHeaderView(item: item)
            AvatarCollectionSheetDividerView(minY: minY)
            
            ScrollView(.vertical, showsIndicators: false) {
                AvatarCollectionListView(collection: item.collectionName)
                    .bottomPartBackgroundEffectOnScrollViewModifier(bottomPartMinY: $minY)
                    .padding(.horizontal)
                    .padding(.top, scrollContentTopPadding)
                    .padding(.bottom, scrollContentBottomPadding)
            }
            .contentMargins(.bottom, footerHeight, for: .scrollIndicators)
            .contentMargins(.top, scrollContentTopPadding, for: .scrollIndicators)
        }
        .presentationDragIndicator(.visible)
        .onAppear { handleOnAppear() }
        .overlay(alignment: .bottom) {
            AvatarCollectionSheetFooterView(footerHeight: $footerHeight)
        }
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
