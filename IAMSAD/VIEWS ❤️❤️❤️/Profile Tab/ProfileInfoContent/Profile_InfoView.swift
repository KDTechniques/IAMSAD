//
//  Profile_InfoView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI

struct Profile_InfoView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var profileVM: ProfileViewModel
    
    // MARK: - BODY
    var body: some View {
        CustomUIScrollView(.vertical, contentOffset: .constant(profileVM.contentOffset)) {
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Profile_TopClearView()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            ProfilePrimaryPhotoView()
                            Spacer()
                            Profile_GeneralNShareButtonsView(buttonType: profileVM.buttonType)
                        }
                        
                        Profile_NameGenderNJoinedDateView(
                            name: profileVM.name,
                            badgeType: profileVM.badgeType,
                            gender: profileVM.gender,
                            joinedDate: profileVM.joinedDate
                        )
                    }
                    
                    if !profileVM.bioText.isEmpty {
                        Profile_BioView(bioText: profileVM.bioText)
                            .padding(.top)
                    }
                    
                    Profile_FollowersCountNLinkView(
                        _3FollowersArray: profileVM._3FollowersArray,
                        followersCount: profileVM.followersCount,
                        linkText: profileVM.linkText,
                        linkURL: profileVM.linkURL
                    )
                    .padding(.top)
                }
                .background {
                    GeometryReader { geo in
                        Color.clear
                            .preference(key: CustomCGFloatPreferenceKey.self, value: geo.size.height)
                            .onPreferenceChange(CustomCGFloatPreferenceKey.self) {
                                profileVM.setProfileContentHeight($0)
                            }
                    }
                }
                
                BottomClearView()
            }
            .padding(.horizontal)
            .frame(width: screenWidth)
        }
        .showsVerticalScrollIndicator(false)
        .ignoresSafeArea(edges: .top)
    }
}

// MARK: - PREVIEWS
#Preview("Profile_InfoView") {
    Profile_InfoView()
        .previewViewModifier
}

// MARK: - SUBVIEWS

// MARK: - BottomClearView
fileprivate struct BottomClearView: View {
    // MARK: - BODY
    var body: some View {
        Color.clear
            .frame(height: screenHeight*3)
            .allowsHitTesting(false)
            .disabled(true)
    }
}
