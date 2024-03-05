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
    @EnvironmentObject private var profileFollowersNLinkVM: ProfileFollowersNLinkVM
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 5) {
            followers
            
            if let linkText: String = profileFollowersNLinkVM.linkText {
                link(linkText)
            }
        }
        .foregroundStyle(.secondary)
        .font(.subheadline)
        //        .background(Color.debug)
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
            ForEach(profileFollowersNLinkVM._3FollowersArray, id: \.self) { followerImageURL in
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
            if profileFollowersNLinkVM.followersCount != .zero {
                _3Followers
            }
            
            Text("\(profileFollowersNLinkVM.followersCount.intToKMString()) follower\(profileFollowersNLinkVM.getPlural())")
        }
        .registerProfileTapEvent(event: .followers) {
            // followers action goes here...
            print("followers action got triggered...")
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
                guard let urlString: String = profileFollowersNLinkVM.linkURL,
                      let url: URL = .init(string: urlString) else { return }
                
                UIApplication.shared.open(url)
                print("link action got triggered...")
            }
    }
}
