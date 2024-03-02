//
//  ConfirmationDialogModel.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-08.
//

import SwiftUI

struct ConfirmationDialogModel: Identifiable {
    // MARK: - PROPERTIES
    let id              : String
    let title           : String
    let titleVisibility : Visibility
    let message         : String?
    let buttonsArray    : [ActionSheet.Button]
    
    // MARK: - INITIALIZER
    init(title: String, titleVisibility: Visibility = .visible, message: String? = nil, buttonsArray: [ActionSheet.Button]) {
        self.id = UUID().uuidString
        self.title = title
        self.titleVisibility = titleVisibility
        self.message = message
        self.buttonsArray = buttonsArray
    }
}

// MARK: - FUNCTIONS
/// This function simplifies the process of displaying an confirmation dialog item, eliminating the need to use `isPresented` for each confirmation dialog we create.
@MainActor
func showConfirmationDialog(_ confirmationDialogType: ConfirmationDialogModel) {
    //    ContentViewModel.shared.confirmationDialogItem = confirmationDialogType
}

/// We don't create confirmation dialog items from the view level or final class level as it makes the code harder to organize and less scalable.
/// Instead, we create all the confirmation dialog types here as an enum.
/// This approach keeps all the confirmation dialogs maintainable in one place and allows for scalability in the future, while maintaining an organized code structure.
@MainActor
enum ConfirmationDialogTypes {
    // MARK: - Reusable
    
}
