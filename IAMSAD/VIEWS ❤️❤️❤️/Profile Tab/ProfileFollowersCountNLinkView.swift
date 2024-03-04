//
//  ProfileFollowersCountNLinkView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileFollowersCountNLinkView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var profileVM: ProfileViewModel
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 5) {
            followers
            
            if let linkText: String = profileVM.linkText {
                link(linkText)
            }
        }
        .foregroundStyle(.secondary)
        .font(.subheadline)
        .background(Color.debug)
    }
}

// MARK: - PREVIEWS
#Preview("ProfileFollowersCountNLinkView") {
    ProfileFollowersCountNLinkView()
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension ProfileFollowersCountNLinkView {
    // MARK: - _3Followers
    private var _3Followers: some View {
        HStack(spacing: -8) {
            ForEach(profileVM._3FollowersArray, id: \.self) { followerImageURL in
                Circle()
                    .fill(.tabBarNSystemBackground)
                    .frame(width: 22, height: 22)
                    .overlay {
                        WebImage(
                            url: .init(string: followerImageURL),
                            options: [.scaleDownLargeImages]
                        )
                        .resizable()
                        .defaultBColorPlaceholder
                        .scaledToFill()
                        .clipShape(Circle())
                        .padding(1.5)
                    }
            }
        }
        .padding(.trailing, 2)
    }
    
    // MARK: - followers
    private var followers: some View {
        HStack(spacing: 5) {
            if profileVM.followersCount != .zero {
                _3Followers
            }
            
            Text("\(profileVM.followersCount.intToKMString()) follower\(getPlural())")
        }
        .registerProfileTapEvent(event: .followers) {
            // followers action goes here...
            print("followers action got triggered...")
            profileVM.followersCount = Int.random(in: 100...1000)
        }
    }
    
    // MARK: - link
    @ViewBuilder
    private func link(_ linkText: String) -> some View {
        Circle()
            .fill(.secondary)
            .frame(width: 2, height: 2)
            .offset(y: 2)
        
        Text(linkText)
            .tint(.secondary)
            .registerProfileTapEvent(event: .link) {
                guard let urlString: String = profileVM.linkURL,
                      let url: URL = .init(string: urlString) else { return }
                
                UIApplication.shared.open(url)
                print("link action got triggered...")
                profileVM.followersCount = Int.random(in: 100...1000)
            }
    }
    
    // MARK: - FUNCTIONS
    private func getPlural() -> String {
        profileVM.followersCount == 0 || profileVM.followersCount > 1 ? "s" : ""
    }
}
