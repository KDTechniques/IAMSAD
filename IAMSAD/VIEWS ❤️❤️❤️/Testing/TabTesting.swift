//
//  TabTesting.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-08.
//

import SwiftUI

enum TabTypes { case home, search, conversations, activity, profile }

struct TabTesting: View {
    
    @State private var tabSelection: TabTypes = .conversations
    
    var body: some View {
        TabView(selection: $tabSelection) {
            ZStack {
                Color.tabBarNSystemBackground.ignoresSafeArea(edges: .top)
            }
            .tabItem {
                Image(tabSelection == .home ? .homeFill : .home)
                Text("Home")
            }
            .tag(TabTypes.home)
            
            ZStack {
                Color.tabBarNSystemBackground.ignoresSafeArea(edges: .top)
            }
            .tabItem { Label { Text("Search") } icon: { Image(.search) } }
            .tag(TabTypes.search)
            
            ZStack {
                Color.tabBarNSystemBackground.ignoresSafeArea(edges: .top)
                ConversationsView()
            }
            .tabItem {
                Image(tabSelection == .conversations ? .conversationsFill : .conversations)
                Text("Conversations")
            }
            .tag(TabTypes.conversations)
            .badge(3)
            
            ZStack {
                Color.tabBarNSystemBackground.ignoresSafeArea(edges: .top)
            }
            .tabItem {
                Image(tabSelection == .activity ? .activityFill : .activity)
                Text("Activity")
            }
            .tag(TabTypes.activity)
            .badge(12)
            
            ZStack {
                Color.tabBarNSystemBackground.ignoresSafeArea(edges: .top)
                ProfileView()
            }
            .tabItem {
                Image(tabSelection == .profile ? .profileFill : .profile)
                Text("Profile")
            }
            .tag(TabTypes.profile)
        }
        .tint(.primary)
    }
}

#Preview {
    TabTesting()
        .previewViewModifier
}
