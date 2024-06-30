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
    
    @State var sliderValue: CGFloat = 0
    @State var color: ColorPaletteModel = Color.defaultAvatarColorPaletteArray[2]
    
    var body: some Scene {
        WindowGroup {
            ScrollView(.vertical) {
                AvatarSheetView()
            }
            .scrollDisabled(true)
            .dynamicTypeSize(...DynamicTypeSize.xLarge)
            .environmentObject(avatar)
            .environmentObject(avatarSheetVM)
            .environmentObject(profileVM)
            .environmentObject(conversationsVM)
        }
    }
}
