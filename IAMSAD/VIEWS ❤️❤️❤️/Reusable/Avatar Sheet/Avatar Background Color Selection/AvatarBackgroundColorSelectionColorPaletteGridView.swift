//
//  AvatarBackgroundColorSelectionColorPaletteGridView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-06-27.
//

import SwiftUI

struct AvatarBackgroundColorSelectionColorPaletteGridView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var avatarSheetVM: AvatarSheetVM
    
    // MARK: - BODY
    var body: some View {
        LazyVGrid(columns: avatarSheetVM.backgroundColorColumns) {
            ForEach(avatarSheetVM.colorPalettesArray) { ColorCircle(color: $0) }
        }
        .padding(.bottom, 6)
    }
}

// MARK: - PREVIEWS
#Preview("AvatarBackgroundColorSelectionColorPaletteGridView") {
    AvatarBackgroundColorSelectionColorPaletteGridView()
        .previewViewModifier
}

// MARK: - SUBVIEWS
fileprivate struct ColorCircle: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var avatarSheetVM: AvatarSheetVM
    
    let color: ColorPaletteModel
    
    // MARK: - BODY
    var body: some View {
        Circle()
            .fill(Color(hue: color.hue, saturation: color.saturation, brightness: color.brightness))
            .overlay(
                Circle()
                    .strokeBorder(.ultraThinMaterial, style: .init(
                        lineWidth: 2.5,
                        lineCap: .round,
                        lineJoin: .round
                    ))
            )
            .padding(5)
            .background(
                Circle()
                    .strokeBorder(.accent, style: .init(
                        lineWidth: 2.5,
                        lineCap: .round,
                        lineJoin: .round
                    ))
                    .opacity(avatarSheetVM.selectedBackgroundColor.id == color.id ? 1 : 0)
            )
            .onTapGesture { avatarSheetVM.handleColorTap(color: color) }
    }
}
