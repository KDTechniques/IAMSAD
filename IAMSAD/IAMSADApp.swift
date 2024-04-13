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
    @State var status: ReadReceiptStatusTypes = .seen
    
    init() {
        
    }
    
    var body: some Scene {
        WindowGroup {
            ScrollView(.vertical) {
                LazyVStack {
                    Conversations_TextOnlyBubbleTypeView(
                        text: "Hello there 👋👋👋",
                        timestamp: "06:12 PM",
                        status: status,
                        userType: .sender,
                        showPointer: true,
                        shouldAnimate: .random()
                    )
                    .onTapGesture {
                        status = .random()
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

