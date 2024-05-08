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
            ZStack {
                Color.conversationBackground
                    .ignoresSafeArea()
                
                Conversations_DocumentAudioPrimaryPlainBubbleView(
                    direction: .random(),
                    showPointer: .random(),
                    fileData: .init(
                        fileURLString: "",
                        fileName: "New Recording.m4a",
                        fileSize: "12 KB",
                        fileExtension: "m4a",
                        duration: .zero
                    ),
                    timestamp: "12:45 PM",
                    status: .random(),
                    shouldAnimate: .random()
                )
            }
            .dynamicTypeSize(...DynamicTypeSize.xLarge)
            .environmentObject(avatar)
            .environmentObject(avatarSheetVM)
            .environmentObject(profileVM)
            .environmentObject(conversationsVM)
        }
    }
}
