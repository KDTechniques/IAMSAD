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
            Utilities().setTabBarColor()
            return true
        }
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    let avatar: Avatar = .shared
    @StateObject private var avatarSheetVM: AvatarSheetVM = .shared
    @StateObject private var profileVM: ProfileViewModel = .shared
    
    var body: some Scene {
        WindowGroup {
            TabTesting()
                .dynamicTypeSize(...DynamicTypeSize.xLarge)
                .environmentObject(avatar)
                .environmentObject(avatarSheetVM)
                .environmentObject(profileVM)
        }
    }
}



