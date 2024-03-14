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
                    horizontalTabHeight: profileVM.horizontalTabHeight
                )
                
                ForEach(profileVM.array) { item in
                    MockText(item: item)
                        .padding(.bottom, 100)
                }
                .padding(.top)
            }
            .introspect(.scrollView, on: .iOS(.v17), scope: .ancestor) { scrollView in
               
                if profileVM.selectedTabType != .replies ,
                   profileVM.contentOffset.y <= profileVM.contentOffsetMaxY {
                    scrollView.contentOffset.y = profileVM.contentOffset.y
                    print("Replies Introspect: \(profileVM.selectedTabType.rawValue)")
                }
            }
        }
        
        .ignoresSafeArea()
    }
}

// MARK: - PREVIEWS
#Preview("Profile_RepliesTabView") {
    Profile_RepliesTabView()
}
