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
    
    @State private var avatarSheetVM: AvatarSheetVM = .shared
    @StateObject private var profileVM: ProfileVM = .shared
    @StateObject private var conversationsVM: ConversationsVM = .shared
    
    init() {
        
    }
    
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
