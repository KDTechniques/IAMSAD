//
//  AvatarBackgroundColorSelectionView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-13.
//

import SwiftUI

struct AvatarBackgroundColorSelectionView: View {
    // MARK: - PROPERTIES
    @Environment(AvatarSheetVM.self) private var vm
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 20) {
            AvatarBackgroundColorSelectionHeaderTextView()
            AvatarBackgroundColorSelectionColorPaletteGridView()
            
            CustomColorSliderView()
                .padding(.horizontal, 8)
        }
        .padding(.horizontal, 20)
        .onChange(of: vm.selectedBackgroundColor) { vm.onColorChange($1) }
        .onAppear { vm.setSliderValue() }
        .onDisappear { vm.setSliderValue() }
    }
}

#Preview("AvatarBackgroundColorSelectionView") {
    AvatarBackgroundColorSelectionView()
        .previewViewModifier
}
