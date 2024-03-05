//
//  ProfileNameGenderNJoinedDateVM.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-05.
//

import Foundation

@MainActor
final class ProfileNameGenderNJoinedDateVM: ObservableObject {
    // MARK: - PROPERTIES
    @Published var name: String = "Deepashika Sajeewanie"
    @Published var badgeType: VerifiedBadgeTypes? = .blue
    @Published var gender: GenderTypes = .female
    @Published var joinedDate: String = "June 2023"
    
    
    // MARK: - Singleton
    static let shared: ProfileNameGenderNJoinedDateVM = .init()
    
    // MARK: - INITIALIZER
    private init() {
        
    }
    
    // MARK: - FUNCTIONS
}
