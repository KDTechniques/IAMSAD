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
    @EnvironmentObject private var profileVM: ProfileVM
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                Profile_TabContentTopClearView(
                    topContentHeight: profileVM.profileContentHeight,
                    horizontalTabHeight: profileVM.horizontalTabHeight,
                    tab: .achievements,
                    selectedTab: profileVM.selectedTabType
                )
                
                ForEach(profileVM.array) { item in
                    MockText(item: item)
                        .padding(.bottom, 100)
                }
                .padding(.top)
            }
        }
        .profileTabContentsIntrospect(vm: profileVM, tab: .achievements)
        .ignoresSafeArea(edges: .top)
    }
}

// MARK: - PREVIEWS
#Preview("Profile_AchievementsTabView") {
    Profile_AchievementsTabView()
}
