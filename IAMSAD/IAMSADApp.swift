//
//  IAMSADApp.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-08.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct IAMSADApp: App {
    // Register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @State private var avatarSheetVM: AvatarSheetVM = .shared
    @StateObject private var profileVM: ProfileVM = .shared
    @StateObject private var conversationsVM: ConversationsVM = .shared
    
    var body: some Scene {
        WindowGroup {
            Color.clear
                .sheet(isPresented: .constant(true), content: {
                    AvatarSheetView()
                })
                .dynamicTypeSize(...DynamicTypeSize.xLarge)
                .environment(avatarSheetVM)
                .environmentObject(profileVM)
                .environmentObject(conversationsVM)
        }
    }
}
