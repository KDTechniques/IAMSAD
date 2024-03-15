//
//  AvatarSheetVM.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-13.
//

import SwiftUI

@MainActor
final class AvatarSheetVM: ObservableObject {
    // MARK: - PROPERTIES
    static let shared: AvatarSheetVM = .init()
    
    // MARK: - INITIALIZER
    private init() { }
    
    // MARK: - Common
    let haptic: HapticFeedbackGenerator = .init()
    let avatarColumns: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible())
    ]
    
    // MARK: - AvatarSheetView
    @Published var selectedAvatar: AvatarModel? = nil
    @Published var selectedBackgroundColor: ColorPaletteModel = Color.defaultAvatarColorPaletteArray[2]
    @Published var isPresentedAvatarSheet: Bool = false
    
    // MARK: - AvatarSelectionView
    @Published var selectedTabCollection: AvatarCollectionTypes = .featured
    @Published var lazyVGridHeight: CGFloat = 0
    @Published var isPresentedSeeAllSheet: Bool = false
    
    // MARK: - AvatarBackgroundColorSelectionView
    @Published var colorPalettesArray: [ColorPaletteModel] = Color.defaultAvatarColorPaletteArray
    @Published var sliderValue: CGFloat = -0.5
    @Published var sliderValueWithAnimation: CGFloat = -0.5
    let backgroundColorColumns: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible())
    ]
    
    // MARK: - FUNCTIONS
    
    // MARK: - COMMON
    
    // MARK: - setSliderValueWithAnimation
    func setSliderValueWithAnimation() {
        if selectedBackgroundColor.saturation == 1.0 && selectedBackgroundColor.brightness == 1.0 {
            sliderValueWithAnimation = .zero
        } else if selectedBackgroundColor.brightness == 1.0 {
            sliderValueWithAnimation = selectedBackgroundColor.saturation - 1
        } else if selectedBackgroundColor.saturation == 1.0 {
            sliderValueWithAnimation = 1 - selectedBackgroundColor.brightness
        }
    }
    
    // MARK: - setSliderValue
    func setSliderValue() {
        if selectedBackgroundColor.saturation == 1.0 && selectedBackgroundColor.brightness == 1.0 {
            sliderValue = .zero
        } else if selectedBackgroundColor.brightness == 1.0 {
            sliderValue = selectedBackgroundColor.saturation - 1
        } else if selectedBackgroundColor.saturation == 1.0 {
            sliderValue = 1 - selectedBackgroundColor.brightness
        }
    }
    
    // MARK: - AvatarBackgroundColorSelectionView
    
    // MARK: - handleColorTap
    func handleColorTap(color: ColorPaletteModel) {
        withAnimation { selectedBackgroundColor = color }
        setSliderValueWithAnimation()
    }
    
    // MARK: - onColorChange
    func onColorChange(_ color: ColorPaletteModel) {
        guard let index: Int = colorPalettesArray.firstIndex(where: { $0.id == color.id }) else { return }
        colorPalettesArray[index].changeColor(s: color.saturation, b: color.brightness)
    }
}
