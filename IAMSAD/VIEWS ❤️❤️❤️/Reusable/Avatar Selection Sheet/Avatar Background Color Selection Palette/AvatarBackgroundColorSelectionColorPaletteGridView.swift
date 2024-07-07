//
//  AvatarBackgroundColorSelectionColorPaletteGridView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-06-27.
//

import SwiftUI

struct AvatarBackgroundColorSelectionColorPaletteGridView: View {
    // MARK: - PROPERTIES
    @Environment(AvatarSheetVM.self) private var vm
    
    // MARK: - BODY
    var body: some View {
        LazyVGrid(columns: vm.backgroundColorColumns) {
            ForEach(vm.colorPalettesArray) { ColorCircle(color: $0) }
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

// MARK: - ColorCircle
fileprivate struct ColorCircle: View {
    // MARK: - PROPERTIES
    @Environment(AvatarSheetVM.self) private var vm
    
    let color: ColorPaletteModel
    
    // MARK: - BODY
    var body: some View {
        JustColorCircle(color: color)
            .background(
                Circle()
                    .strokeBorder(.accent, style: .init(
                        lineWidth: 2.5,
                        lineCap: .round,
                        lineJoin: .round
                    ))
                    .opacity(vm.selectedBackgroundColor.id == color.id ? 1 : 0)
            )
            .onTapGesture { vm.handleColorTap(color: color) }
    }
}

// MARK: - JustColorCircle
fileprivate struct JustColorCircle: View {
    // MARK: - PROPERTIES
    let color: ColorPaletteModel
    
    // MARK: - BODY
    var body: some View {
        Circle()
            .fill(Color(
                hue: color.hue,
                saturation: color.saturation,
                brightness: color.brightness
            ))
            .overlay(
                Circle()
                    .strokeBorder(.ultraThinMaterial, style: .init(
                        lineWidth: 2.5,
                        lineCap: .round,
                        lineJoin: .round
                    ))
            )
            .padding(5)
    }
}

