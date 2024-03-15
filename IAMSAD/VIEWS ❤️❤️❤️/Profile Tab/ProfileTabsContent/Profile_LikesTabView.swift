//
//  Profile_LikesTabView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-13.
//

import SwiftUI

struct Profile_LikesTabView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var profileVM: ProfileVM
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                Profile_TabContentTopClearView(
                    topContentHeight: profileVM.profileContentHeight,
                    horizontalTabHeight: profileVM.horizontalTabHeight,
                    tab: .likes,
                    selectedTab: profileVM.selectedTabType
                )
                
                ForEach(profileVM.array) { item in
                    MockText(item: item)
                        .padding(.bottom, 100)
                }
                .padding(.top)
            }
        }
        .profileTabContentsIntrospect(vm: profileVM, tab: .likes)
        .ignoresSafeArea(edges: .top)
    }
}

// MARK: - PREVIEWS
#Preview("Profile_LikesTabView") {
    Profile_LikesTabView()
}
