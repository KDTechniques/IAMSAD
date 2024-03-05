//
//  IAMSADApp.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-08.
//

import SwiftUI

@main
struct IAMSADApp: App {
    final class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

            return true
        }
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    let avatar: Avatar = .shared
    @StateObject private var avatarSheetVM: AvatarSheetVM = .shared
    @StateObject private var profileVM: ProfileViewModel = .shared
    @StateObject private var profileCoverVM: ProfileCoverVM = .shared
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
                .environmentObject(profileCoverVM)
                .environmentObject(profileGeneralNShareButtonsVM)
                .environmentObject(profileNameGenderNJoinedDateVM)
                .environmentObject(profileBioVM)
                .environmentObject(profileFollowersNLinkVM)
        }
    }
}



