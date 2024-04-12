//
//  IAMSADApp.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-08.
//

import SwiftUI
import SwiftUIIntrospect

@main
struct IAMSADApp: App {
    
    let avatar: Avatar = .shared
    @StateObject private var avatarSheetVM: AvatarSheetVM = .shared
    @StateObject private var profileVM: ProfileVM = .shared
    @StateObject private var conversationsVM: ConversationsVM = .shared
    
    init() {
        
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ZStack {
                    Color.conversationBackground
                        .ignoresSafeArea()
                    
                    Image(.whatsappchatbackgroundimage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: screenWidth, height: screenHeight)
                        .clipped()
                        .ignoresSafeArea()
                        .opacity(0.25)
                    
                    ScrollView(.vertical) {
                        Conversations_StickerOnlyBubbleTypeView(
                            url: .init(string: "https://cdn.pixabay.com/animation/2022/10/11/09/05/09-05-26-529_512.gif"),
                            timestamp: "10:44 PM",
                            userType: .receiver
                        )
                        .padding(.top, screenHeight/2)
                    }
                    .introspect(.scrollView, on: .iOS(.v17)) { scrollview in
                        print("Is Tracking: \(scrollview.isTracking)")
                    }
                }
            }
            .dynamicTypeSize(...DynamicTypeSize.xLarge)
            .environmentObject(avatar)
            .environmentObject(avatarSheetVM)
            .environmentObject(profileVM)
            .environmentObject(conversationsVM)
        }
    }
}

