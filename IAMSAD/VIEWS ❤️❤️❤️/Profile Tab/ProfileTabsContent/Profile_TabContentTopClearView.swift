//
//  Profile_TabContentTopClearView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-12.
//

import SwiftUI

@MainActor
struct Profile_TabContentTopClearView: View {
    // MARK: - PROPERTIES
    let topContentHeight: CGFloat
    let horizontalTabHeight: CGFloat
    let tab: Profile_TabLabelTypes
    let selectedTab: Profile_TabLabelTypes
    
    let profileVM: ProfileViewModel = .shared
    var frameHeight: CGFloat { topContentHeight + horizontalTabHeight }
    
    // MARK: - BODY
    var body: some View {
        Color.clear
            .frame(height: frameHeight > 0 ? frameHeight : .zero)
            .background {
                if tab == selectedTab {
                    GeometryReader { geo in
                        Color.clear
                            .preference(
                                key: CustomCGFloatPreferenceKey.self,
                                value: geo.frame(in: .global).minY
                            )
                            .onPreferenceChange(CustomCGFloatPreferenceKey.self) { value in
                                profileVM.contentOffset.y = -value < profileVM.contentOffsetMaxY
                                ? -value
                                : profileVM.contentOffsetMaxY
                            }
                    }
                }
            }
    }
}

// MARK: - PREVIEWS
#Preview("Profile_TabContentTopClearView") {
    Profile_TabContentTopClearView(
        topContentHeight: 400,
        horizontalTabHeight: 100,
        tab: .posts,
        selectedTab: .posts
    )
    .previewViewModifier
}
