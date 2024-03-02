//
//  AlertModel.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-08.
//

import SwiftUI

struct AlertModel: Identifiable {
    // MARK: - PROPERTIES
    let id              : String = UUID().uuidString
    let title           : String
    let message         : String
    let hapticType      : AlertHapticTypes
    let primaryAction   : Alert.Button
    let secondaryAction : Alert.Button?
    
    // MARK: - INITIALIZER
    init(title: String, message: String = "", hapticType: AlertHapticTypes, primaryAction: Alert.Button, secondaryAction: Alert.Button? = nil) {
        self.title = title
        self.message = message
        self.hapticType = hapticType
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }
}

// MARK: - FUNCTIONS
/// This function simplifies the process of displaying an alert item, eliminating the need to use `isPresented` for each alert we create.
@MainActor
func showAlert(_ alertType: AlertModel) {
    //    ContentViewModel.shared.alertItem = alertType
}

// MARK: - ENUMS
enum AlertHapticTypes { case warning, error, success }

/// We don't create alert items from the view level or final class level as it makes the code harder to organize and less scalable.
/// Instead, we create all the alert types here as an enum.
/// This approach keeps all the alerts maintainable in one place and allows for scalability in the future, while maintaining an organized code structure.
@MainActor
enum AlertTypes {
    // MARK: - Reusable
    
    // MARK: - noConnection
    static let noConnection: AlertModel = .init(
        title: "No Internet Connection",
        message: "Please check your internet connection and try again.",
        hapticType: .warning,
        primaryAction: .default(Text("OK"))
    )
    
    // MARK: - anErrorOccurred
    static let anErrorOccurred: AlertModel = .init(
        title: "An Error Occurred",
        message: "We'll fix it as soon as possible.",
        hapticType: .error,
        primaryAction: .default(Text("OK"))
    )
}
