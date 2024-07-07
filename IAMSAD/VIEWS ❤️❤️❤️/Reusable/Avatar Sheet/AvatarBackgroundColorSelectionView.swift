//
//  AvatarBackgroundColorSelectionView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-13.
//

import SwiftUI

struct AvatarBackgroundColorSelectionView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var avatarSheetVM: AvatarSheetVM
    
    private var sectionHeaderColor: Color {
        colorScheme == .dark ? Color(uiColor: .lightGray) : Color(uiColor: .darkGray)
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 20) {
            headerText
            colorPaletteGrid
            
            CustomColorSliderView(
                sliderValue: $avatarSheetVM.sliderValue,
                sliderValueWithAnimation: $avatarSheetVM.sliderValueWithAnimation,
                color: $avatarSheetVM.selectedBackgroundColor
            )
            .padding(.horizontal, 8)
        }
        .padding(.horizontal, 20)
        .onChange(of: avatarSheetVM.selectedBackgroundColor) { avatarSheetVM.onColorChange($1) }
        .onAppear { avatarSheetVM.setSliderValue() }
        .onDisappear { avatarSheetVM.setSliderValue() }
    }
}

// MARK: - EXTENSIONS
@MainActor
extension AvatarBackgroundColorSelectionView {
    // MARK: - headerText
    private var headerText: some View {
        Text("Background Color")
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(sectionHeaderColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - colorPalette
    private var colorPaletteGrid: some View {
        LazyVGrid(columns: avatarSheetVM.backgroundColorColumns) {
            ForEach(avatarSheetVM.colorPalettesArray) { colorCircle(color: $0) }
        }
        .padding(.bottom, 6)
    }
    
    // MARK: - colorCircle
    private func colorCircle(color: ColorPaletteModel) -> some View {
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
