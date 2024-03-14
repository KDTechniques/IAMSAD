//
//  Profile_RepliesTabView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-13.
//

import SwiftUI

struct Profile_RepliesTabView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var profileVM: ProfileViewModel
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                Profile_TabContentTopClearView(
                    topContentHeight: profileVM.profileContentHeight,
                    horizontalTabHeight: profileVM.horizontalTabHeight,
                    tab: .replies,
                    selectedTab: profileVM.selectedTabType
                )
                
                ForEach(profileVM.array) { item in
                    MockText(item: item)
                        .padding(.bottom, 100)
                }
                .padding(.top)
            }
        }
        .introspect(.scrollView, on: .iOS(.v17)) { scrollView in
            let condition: Bool = profileVM.contentOffset.y <= profileVM.contentOffsetMaxY
            
            if profileVM.currentGestureType == .drag {
                if profileVM.selectedTabType != .replies, condition {
                    scrollView.contentOffset.y = profileVM.contentOffset.y
                }
            } else if condition {
                scrollView.contentOffset.y = profileVM.contentOffset.y
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - PREVIEWS
#Preview("Profile_RepliesTabView") {
    Profile_RepliesTabView()
        .previewViewModifier
}
