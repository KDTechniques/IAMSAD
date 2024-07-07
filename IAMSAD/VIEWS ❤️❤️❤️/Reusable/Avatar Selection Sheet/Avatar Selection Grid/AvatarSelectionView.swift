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
            AvatarSelectionTabContentView()
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
