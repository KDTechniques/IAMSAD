//
//  AvatarBackgroundColorSelectionView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-13.
//

import SwiftUI

struct AvatarBackgroundColorSelectionView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var avatarSheetVM: AvatarSheetVM
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 20) {
            AvatarBackgroundColorSelectionHeaderTextView()
            AvatarBackgroundColorSelectionColorPaletteGridView()
            
            CustomColorSliderView()
                .padding(.horizontal, 8)
        }
        .padding(.horizontal, 20)
        .onChange(of: avatarSheetVM.selectedBackgroundColor) { avatarSheetVM.onColorChange($1) }
        .onAppear { avatarSheetVM.setSliderValue() }
        .onDisappear { avatarSheetVM.setSliderValue() }
    }
}

#Preview("AvatarBackgroundColorSelectionView") {
    AvatarBackgroundColorSelectionView()
        .previewViewModifier
}
