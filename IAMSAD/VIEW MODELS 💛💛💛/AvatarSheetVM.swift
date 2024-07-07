//
//  AvatarSheetVM.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-13.
//

import SwiftUI
import Combine

@MainActor
@Observable final class AvatarSheetVM {
    // MARK: - PROPERTIES
    static let shared: AvatarSheetVM = .init()
    
    // MARK: - Common
    let haptic: HapticFeedbackGenerator = .init()
    let avatarColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 5)
    private var cancelable: Set<AnyCancellable> = []
    
    // MARK: - AvatarSheetView
    var selectedAvatar: AvatarModel? = nil
    var selectedBackgroundColor: ColorPaletteModel = Color.defaultAvatarColorPaletteArray[2] {
        didSet { selectedBackgroundColor$ = selectedBackgroundColor }
    }
    @ObservationIgnored
    @Published private var selectedBackgroundColor$: ColorPaletteModel = Color.defaultAvatarColorPaletteArray[2]
    var isPresentedAvatarSheet: Bool = false
    
    // MARK: - AvatarSelectionView
    var selectedTabCollection: AvatarCollectionTypes = .featured
    var lazyVGridHeight: CGFloat = 0
    var isPresentedSeeAllSheet: Bool = false
    
    // MARK: - AvatarBackgroundColorSelectionView
    var colorPalettesArray: [ColorPaletteModel] = Color.defaultAvatarColorPaletteArray
    var sliderValue: CGFloat = -0.5
    var sliderValueWithAnimation: CGFloat = -0.5
    let backgroundColorColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 6)
    
    // MARK: - INITIALIZER
    private init() {
        backgroundColorSubscriber()
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - COMMON
    
    // MARK: - backgroundColorSubscriber
    private func backgroundColorSubscriber() {
        $selectedBackgroundColor$
            .removeDuplicates()
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .sink { [weak self] newValue in
                guard let self = self else { return }
                selectedAvatar?.updateBackgroundColor(newValue.toColor())
            }
            .store(in: &cancelable)
    }
    
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
