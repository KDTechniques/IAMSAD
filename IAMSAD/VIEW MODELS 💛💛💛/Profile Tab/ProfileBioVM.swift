//
//  ProfileBioVM.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-05.
//

import Foundation

@MainActor
final class ProfileBioVM: ObservableObject {
    // MARK: - PROPERTIES
    @Published var bioText: String = "Sajee's Hubby 👩🏻‍❤️‍👨🏻\n1st Class Honours Graduate 👨🏻‍🎓\nUI/UX Designer/Engineer 👨🏻‍💻\nFront-End SwiftUI iOS Develoer 👨🏻‍💻"
    
    // MARK: - Singleton
    static let shared: ProfileBioVM = .init()
    
    // MARK: - INITIALIZER
    private init() {
        
    }
    
    // MARK: - FUNCTIONS
}
