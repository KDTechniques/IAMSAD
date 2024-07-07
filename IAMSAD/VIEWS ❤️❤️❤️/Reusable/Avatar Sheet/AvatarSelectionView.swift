//
//  AvatarSelectionView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-13.
//

import SwiftUI

struct AvatarSelectionView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var avatar: Avatar
    @EnvironmentObject private var avatarSheetVM: AvatarSheetVM
    
    private var sectionHeaderColor: Color {
        colorScheme == .dark ? Color(uiColor: .lightGray) : Color(uiColor: .darkGray)
    }
    
    // MARK: - INITIALIZER
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .gray
        UIPageControl.appearance().pageIndicatorTintColor = .systemGray5
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 20) {
            avatarCollectionNameText
            tabContent
        }
        .overlay(alignment: .topTrailing) { seeAllButton }
        .font(.subheadline)
        .sheet(
            isPresented: $avatarSheetVM.isPresentedSeeAllSheet,
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
    // MARK: - avatarCell
    @ViewBuilder
    private func avatarCell(collectionName: AvatarCollectionTypes) -> some View {
        let avatarsArray: [AvatarModel] = Array(avatar.publicAvatarsArray.filter({ $0.collection == collectionName }).prefix(20))
        
        LazyVGrid(columns: avatarSheetVM.avatarColumns) {
            ForEach(avatarsArray) {
                CustomSelectableAvatarView(
                    selectedAvatar: $avatarSheetVM.selectedAvatar,
                    avatar: $0,
                    staticColor: Color(
                        hue: avatarSheetVM.selectedBackgroundColor.hue,
                        saturation: avatarSheetVM.selectedBackgroundColor.saturation,
                        brightness: avatarSheetVM.selectedBackgroundColor.brightness
                    )
                )
            }
        }
    }
    
    // MARK: - avatarCollectionNameText
    private var avatarCollectionNameText: some View {
        Text(avatarSheetVM.selectedTabCollection.rawValue)
            .fontWeight(.semibold)
            .foregroundStyle(sectionHeaderColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
    }
    
    // MARK: - tabContent
    private var tabContent: some View {
        TabView(selection: $avatarSheetVM.selectedTabCollection) {
            ForEach(AvatarCollectionTypes.allCases, id: \.self) { avatarCell(collectionName: $0) }
                .padding(.horizontal, 20)
                .geometryReaderDimensionViewModifier($avatarSheetVM.lazyVGridHeight, dimension: .height)
                .frame(maxHeight: avatarSheetVM.lazyVGridHeight)
        }
        .frame(height: avatarSheetVM.lazyVGridHeight+90)
        .frame(height: avatarSheetVM.lazyVGridHeight+45, alignment: .bottom)
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
    
    // MARK: - seeAllButton
    private var seeAllButton: some View {
        Button { avatarSheetVM.isPresentedSeeAllSheet = true } label: {
            Text("See All")
                .fontWeight(.medium)
                .padding(.horizontal, 20)
        }
    }
}
