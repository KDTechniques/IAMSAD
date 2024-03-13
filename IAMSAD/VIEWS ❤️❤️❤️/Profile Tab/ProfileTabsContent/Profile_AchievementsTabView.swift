//
//  Profile_AchievementsTabView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-13.
//

import SwiftUI
import SwiftUIIntrospect

struct Profile_AchievementsTabView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var profileVM: ProfileViewModel
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                Profile_TabContentTopClearView(
                    topContentHeight: profileVM.profileContentHeight,
                    horizontalTabHeight: profileVM.horizontalTabHeight
                )
                
                ForEach(profileVM.array) { item in
                    MockText(item: item)
                        .padding(.bottom, 100)
                }
                .padding(.top)
            }
        }
        .profile_introspectViewModifier(for: .achievements)
        .ignoresSafeArea()
    }
}

// MARK: - PREVIEWS
#Preview("Profile_AchievementsTabView") {
    Profile_AchievementsTabView()
}
