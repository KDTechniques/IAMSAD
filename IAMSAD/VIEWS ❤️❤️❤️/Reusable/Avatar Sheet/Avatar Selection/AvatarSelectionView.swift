//
//  AvatarSelectionView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-13.
//

import SwiftUI

struct AvatarSelectionView: View {
    // MARK: - PROPERTIES
    @Environment(AvatarSheetVM.self) private var avatarSheetVM
    @State private var avatarSheetVM$: AvatarSheetVM = .shared
    
    // MARK: - INITIALIZER
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .gray
        UIPageControl.appearance().pageIndicatorTintColor = .systemGray5
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 20) {
            AvatarSelectionHeaderTitleView()
            tabContent
        }
        .overlay(alignment: .topTrailing) { AvatarSelectionHeaderButtonView() }
        .font(.subheadline)
        .sheet(
            isPresented: $avatarSheetVM$.isPresentedSeeAllSheet,
            onDismiss: { avatarSheetVM.setSliderValueWithAnimation() }
        ) { SeeAllAvatarSheetContentView() }
    }
}

// MARK: - PREVIEWS
#Preview("AvatarSelectionView") {
    AvatarSelectionView()
        .previewViewModifier
}

// MARK: - EXTENSIONS
@MainActor
extension AvatarSelectionView {
    // MARK: - tabContent
    private var tabContent: some View {
        TabView(selection: $avatarSheetVM$.selectedTabCollection) {
            ForEach(AvatarCollectionTypes.allCases, id: \.self) { AvatarSelectionVGridView(collectionName: $0) }
                .padding(.horizontal, 20)
                .geometryReaderDimensionViewModifier($avatarSheetVM$.lazyVGridHeight, dimension: .height)
                .frame(maxHeight: avatarSheetVM.lazyVGridHeight)
        }
        .frame(height: avatarSheetVM.lazyVGridHeight+90)
        .frame(height: avatarSheetVM.lazyVGridHeight+45, alignment: .bottom)
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
}
