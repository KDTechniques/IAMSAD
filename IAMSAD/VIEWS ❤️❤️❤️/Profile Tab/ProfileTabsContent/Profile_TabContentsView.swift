//
//  Profile_TabContentsView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-14.
//

import SwiftUI

struct Profile_TabContentsView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var profileVM: ProfileViewModel
    
    // MARK: - BODY
    var body: some View {
        CustomStripTabView(
            horizontalTabHeight: $profileVM.horizontalTabHeight,
            contentArray: [
                .init(content: AnyView(Profile_PostsTabView()), label: "Posts"),
                .init(content: AnyView(Profile_PostsTabView()), label: "Replies"),
                .init(content: AnyView(Profile_PostsTabView()), label: "Media"),
                .init(content: AnyView(Profile_PostsTabView()), label: "Likes"),
                .init(content: AnyView(Profile_PostsTabView()), label: "Bookmarks"),
                .init(content: AnyView(Profile_PostsTabView()), label: "Achievements")
            ],
            horizontalTabOffsetY: profileVM.profileContentHeight - profileVM.contentOffset.y
        )
    }
}

// MARK: - PREVIEWS
#Preview("Profile_TabContentsView") {
    Profile_TabContentsView()
        .previewViewModifier
}
