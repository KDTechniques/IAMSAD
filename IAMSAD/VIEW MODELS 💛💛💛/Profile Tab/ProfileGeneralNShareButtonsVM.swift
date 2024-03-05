//
//  ProfileGeneralNShareButtonsVM.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-05.
//

import Foundation

@MainActor
final class ProfileGeneralNShareButtonsVM: ObservableObject {
    // MARK: - PROPERTIES
    @Published var buttonType: ProfileGeneralButtonTypes = .following
    
    // MARK: - Singleton
    static let shared: ProfileGeneralNShareButtonsVM = .init()
    
    // MARK: - INITIALIZER
    private init() {
        
    }
    
    // MARK: - FUNCTIONS
}
