//
//  Profile_TabContentsView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-14.
//

import SwiftUI

struct Profile_TabContentsView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var profileVM: ProfileVM
    
    // MARK: - BODY
    var body: some View {
        CustomStripTabView(
            horizontalTabHeight: $profileVM.horizontalTabHeight,
            contentArray: [
                .init(content: AnyView(Profile_PostsTabView()), label: .posts),
                .init(content: AnyView(Profile_RepliesTabView()), label: .replies),
                .init(content: AnyView(Profile_MediaTabView()), label: .media),
                .init(content: AnyView(Profile_LikesTabView()), label: .likes),
                .init(content: AnyView(Profile_BookmarksTabView()), label: .bookmarks),
                .init(content: AnyView(Profile_AchievementsTabView()), label: .achievements)
            ],
            horizontalTabOffsetY: profileVM.profileContentHeight - profileVM.contentOffsetY
        )
        .onTapGesture { handleTap($0) }
    }
}

// MARK: - PREVIEWS
#Preview("Profile_TabContentsView") {
    Profile_TabContentsView()
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension Profile_TabContentsView {
    // MARK: - FUNCTIONS
    
    //  MARK: - handleTap
    /// Handles all touch gestures for the profile info view.
    /// Uses the profileVM class to manage touch events and register untouchable events in an array.
    /// The untouchable events are specified using a model.
    /// Checks the array when a tap occurs and executes relevant actions.
    private func handleTap(_ coordinates: CGPoint) {
        profileVM.tapCoordinates = coordinates
    }
}
