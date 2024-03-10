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
    
    @State var horizontalTabHeight: CGFloat = .zero
    @State var contentStaticMinY: CGFloat = .zero
    
    // MARK: - BODY
    var body: some View {
        CustomStripTabView(
            horizontalTabHeight: $horizontalTabHeight,
            contentArray: [
                .init(
                    content: AnyView(
                        Profile_TabContentView(
                            contentOffset: $profileVM.contentOffset,
                            contentStaticMinY: $contentStaticMinY,
                            topContentHeight: profileVM.profileContentHeight,
                            horizontalTabHeight: horizontalTabHeight) { MockView() }
                    ),
                    label: "Posts"
                ),
                .init(
                    content: AnyView(
                        Profile_TabContentView(
                            contentOffset: $profileVM.contentOffset,
                            contentStaticMinY: $contentStaticMinY,
                            topContentHeight: profileVM.profileContentHeight,
                            horizontalTabHeight: horizontalTabHeight) { MockView() }
                    ),
                    label: "Replies"
                ),
                .init(
                    content: AnyView(
                        Profile_TabContentView(
                            contentOffset: $profileVM.contentOffset,
                            contentStaticMinY: $contentStaticMinY,
                            topContentHeight: profileVM.profileContentHeight,
                            horizontalTabHeight: horizontalTabHeight) { MockView() }
                    ),
                    label: "Media"
                ),
                .init(
                    content: AnyView(
                        Profile_TabContentView(
                            contentOffset: $profileVM.contentOffset,
                            contentStaticMinY: $contentStaticMinY,
                            topContentHeight: profileVM.profileContentHeight,
                            horizontalTabHeight: horizontalTabHeight) { MockView() }
                    ),
                    label: "Likes"
                ),
                .init(
                    content: AnyView(
                        Profile_TabContentView(
                            contentOffset: $profileVM.contentOffset,
                            contentStaticMinY: $contentStaticMinY,
                            topContentHeight: profileVM.profileContentHeight,
                            horizontalTabHeight: horizontalTabHeight) { MockView() }
                    ),
                    label: "Bookmarks"
                ),
                .init(
                    content: AnyView(
                        Profile_TabContentView(
                            contentOffset: $profileVM.contentOffset,
                            contentStaticMinY: $contentStaticMinY,
                            topContentHeight: profileVM.profileContentHeight,
                            horizontalTabHeight: horizontalTabHeight) { MockView() }
                    ),
                    label: "Achievements"
                ),
            ],
            horizontalTabOffsetY: profileVM.profileContentHeight - profileVM.throttledContentOffset.y
        )
    }
}

// MARK: - PREVIEWS
#Preview("Profile_TabContentsView") {
    Profile_TabContentsView()
        .previewViewModifier
}

// MARK: - MOCKS
fileprivate struct MockView: View {
    var body: some View {
        LazyVStack(spacing: 50) {
            ForEach(0...100, id: \.self) { index in
                Button(index.description) {
                    print(index)
                }
                .frame(width: screenWidth)
            }
            .padding(.top)
        }
    }
}
