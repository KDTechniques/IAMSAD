//
//  ContentView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-08.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    @State private var tabSelection: TabTypes = .profile
    
    // MARK: - BODY
    var body: some View {
        TabView(selection: $tabSelection) {
            Text("Home Tab is under constructions.")
                .tabItem {
                    Image(tabSelection == .home ? .homeFill : .home)
                    Text("Home")
                }
                .tag(TabTypes.home)
            
            Text("Search Tab is under constructions.")
                .tabItem { Label { Text("Search") } icon: { Image(.search) } }
                .tag(TabTypes.search)
            
            ConversationsView()
                .tabItem {
                    Image(tabSelection == .conversations ? .conversationsFill : .conversations)
                    Text("Conversations")
                }
                .tag(TabTypes.conversations)
                .badge(3)
            
            Text("Activity Tab is under constructions.")
                .tabItem {
                    Image(tabSelection == .activity ? .activityFill : .activity)
                    Text("Activity")
                }
                .tag(TabTypes.activity)
                .badge(12)
            
            ProfileView()
                .tabItem {
                    Image(tabSelection == .profile ? .profileFill : .profile)
                    Text("Profile")
                }
                .tag(TabTypes.profile)
        }
    }
}

// MARK: - PREVIEWS
#Preview("ContentView") {
    ContentView()
        .previewViewModifier
}
