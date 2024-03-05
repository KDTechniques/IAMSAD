//
//  ProfileFollowersNLinkVM.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-05.
//

import Foundation

@MainActor
final class ProfileFollowersNLinkVM: ObservableObject {
    // MARK: - PROPRTIES
    @Published var _3FollowersArray: [String] = [
        "https://picsum.photos/50/50",
        "https://picsum.photos/51/51",
        "https://picsum.photos/52/52"
    ]
    @Published var followersCount: Int = 1200
    @Published var linkText: String? = "kd_techniques/sleepi.com"
    @Published var linkURL: String? = "https://exmaple.com/"
    
    // MARK: Singleton
    static let shared: ProfileFollowersNLinkVM = .init()
    
    // MARK: - INITIALIZER
    private init() {
        
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - getPlural
    func getPlural() -> String {
        followersCount == 0 || followersCount > 1 ? "s" : ""
    }
}
