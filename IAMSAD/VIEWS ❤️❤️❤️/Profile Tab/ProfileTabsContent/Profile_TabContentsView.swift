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
                .init(content: AnyView(Profile_PostsTabView()), label: .posts),
                .init(content: AnyView(Profile_RepliesTabView()), label: .replies),
                .init(content: AnyView(Profile_MediaTabView()), label: .media)//,
//                .init(content: AnyView(Profile_LikesTabView()), label: .likes),
//                .init(content: AnyView(Profile_BookmarksTabView()), label: .bookmarks),
//                .init(content: AnyView(Profile_AchievementsTabView()), label: .achievements)
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
