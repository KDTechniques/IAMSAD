//
//  IAMSADApp.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-08.
//

import SwiftUI

@main
struct IAMSADApp: App {
    
    let avatar: Avatar = .shared
    @StateObject private var avatarSheetVM: AvatarSheetVM = .shared
    @StateObject private var profileVM: ProfileViewModel = .shared
    @StateObject private var profileGeneralNShareButtonsVM: ProfileGeneralNShareButtonsVM = .shared
    @StateObject private var profileNameGenderNJoinedDateVM: ProfileNameGenderNJoinedDateVM = .shared
    @StateObject private var profileBioVM: ProfileBioVM = .shared
    @StateObject private var profileFollowersNLinkVM: ProfileFollowersNLinkVM = .shared
    
    init() {
        Utilities().setTabBarColor()
    }
    
    var body: some Scene {
        WindowGroup {
            TabTesting()
                .dynamicTypeSize(...DynamicTypeSize.xLarge)
                .environmentObject(avatar)
                .environmentObject(avatarSheetVM)
                .environmentObject(profileVM)
                .environmentObject(profileGeneralNShareButtonsVM)
                .environmentObject(profileNameGenderNJoinedDateVM)
                .environmentObject(profileBioVM)
                .environmentObject(profileFollowersNLinkVM)
        }
    }
}



