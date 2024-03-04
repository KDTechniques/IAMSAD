//
//  ProfileInfoView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI

struct ProfileInfoView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var profileVM: ProfileViewModel
    
    // MARK: - BODY
    var body: some View {
        CustomUIScrollView(.vertical, contentOffset: $profileVM.contentOffset) {
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    ProfileTopClearView()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            ProfilePrimaryPhotoView()
                            
                            Spacer()
                            
                            HStack(spacing: 15) {
                                ProfileGeneralButtonView(buttonType: .editProfile)
                                ProfileShareButtonView()
                            }
                        }
                        
                        ProfileNameGenderNJoinedDateView(
                            name: "Kavinda Dilshan",
                            badgeType: .orange,
                            gender: .male,
                            joinedDate: "December 2023"
                        )
                    }
                    
                    ProfileBioView(bio: "Sajee's Hubby 👩🏻‍❤️‍👨🏻\n1st Class Honours Graduate 👨🏻‍🎓\nUI/UX Designer/Engineer 👨🏻‍💻\nFront-End SwiftUI iOS Develoer 👨🏻‍💻")
                        .padding(.top)
                    
                    ProfileFollowersCountNLinkView()
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
#Preview("ProfileInfoView") {
    ProfileInfoView()
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
