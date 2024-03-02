//
//  HapticFeedbackGenerator.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-08.
//

import SwiftUI

enum VibrationTypes: String, CaseIterable {
    case selection
    case success, error, warning
    case light, medium, soft, rigid, heavy
}

struct HapticFeedbackGeneratorWrapper {
    private let generator = UINotificationFeedbackGenerator()
    
    func selectionOccurred() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    
    func notificationOccurred(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
    
    func impactOccurred(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}

actor HapticFeedbackGenerator {
    private let hapticFeedbackGeneratorWrapper = HapticFeedbackGeneratorWrapper()
    
    @MainActor
    func vibrate(type: VibrationTypes) {
        //        if AccountNSettingsViewModel.shared.isHapticsOn {
        switch type {
        case .success:
            hapticFeedbackGeneratorWrapper.notificationOccurred(.success)
        case .error:
            hapticFeedbackGeneratorWrapper.notificationOccurred(.error)
        case .warning:
            hapticFeedbackGeneratorWrapper.notificationOccurred(.warning)
        case .light:
            hapticFeedbackGeneratorWrapper.impactOccurred(style: .light)
        case .soft:
            hapticFeedbackGeneratorWrapper.impactOccurred(style: .soft)
        case .medium:
            hapticFeedbackGeneratorWrapper.impactOccurred(style: .medium)
        case .rigid:
            hapticFeedbackGeneratorWrapper.impactOccurred(style: .rigid)
        case .heavy:
            hapticFeedbackGeneratorWrapper.impactOccurred(style: .heavy)
        case .selection:
            hapticFeedbackGeneratorWrapper.selectionOccurred()
        }
        //        }
    }
}
