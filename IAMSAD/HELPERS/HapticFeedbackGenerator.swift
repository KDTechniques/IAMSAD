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
    let notificationGenerator = UINotificationFeedbackGenerator()
    let selectionGenerator = UISelectionFeedbackGenerator()
    let heavyImpactGenerator = UIImpactFeedbackGenerator(style: .heavy)
    let lightImpactGenerator = UIImpactFeedbackGenerator(style: .light)
    let mediumImpactGenerator = UIImpactFeedbackGenerator(style: .medium)
    let rigidImpactGenerator = UIImpactFeedbackGenerator(style: .rigid)
    let softImpactGenerator = UIImpactFeedbackGenerator(style: .soft)
    
    func selectionOccurred() {
        selectionGenerator.prepare()
        selectionGenerator.selectionChanged()
    }
    
    func notificationOccurred(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        notificationGenerator.prepare()
        notificationGenerator.notificationOccurred(type)
    }
    
    func impactOccurred(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        switch style {
        case .light:
            lightImpactGenerator.prepare()
            lightImpactGenerator.impactOccurred()
        case .medium:
            mediumImpactGenerator.prepare()
            mediumImpactGenerator.impactOccurred()
        case .heavy:
            heavyImpactGenerator.prepare()
            heavyImpactGenerator.impactOccurred()
        case .soft:
            softImpactGenerator.prepare()
            softImpactGenerator.impactOccurred()
        case .rigid:
            rigidImpactGenerator.prepare()
            rigidImpactGenerator.impactOccurred()
        @unknown default:
            break
        }
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
