//
//  Profile_FollowersCountNLinkView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI
import SDWebImageSwiftUI

struct Profile_FollowersCountNLinkView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    let _3FollowersArray: [String]
    let followersCount: Int
    let linkText: String?
    let linkURL: String?
    
    @State private var isPresentedSheet: Bool = false
    let profileVM: ProfileVM = .shared
    
    // MARK: - INITIALIZER
    init(
        _3FollowersArray: [String],
        followersCount: Int,
        linkText: String?,
        linkURL: String?
    ) {
        self._3FollowersArray = _3FollowersArray
        self.followersCount = followersCount
        self.linkText = linkText
        self.linkURL = linkURL
    }
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 5) {
            followers
            
            if let linkText: String = linkText {
                link(linkText)
            }
        }
        .foregroundStyle(.secondary)
        .font(.subheadline)
    }
}

// MARK: - PREVIEWS
#Preview("Profile_FollowersCountNLinkView") {
    Profile_FollowersCountNLinkView(
        _3FollowersArray: [
            "https://picsum.photos/50",
            "https://picsum.photos/51",
            "https://picsum.photos/52"
        ],
        followersCount: 1400,
        linkText: "kd_techniques/sleepi.com",
        linkURL: "https://exmaple.com/"
    )
    .previewViewModifier
}

// MARK: - EXTENSIONS
extension Profile_FollowersCountNLinkView {
    // MARK: - _3Followers
    private var _3Followers: some View {
        HStack(spacing: -8) {
            ForEach(_3FollowersArray, id: \.self) { followerImageURL in
                Circle()
                    .fill(colorScheme == .dark ? .black : .white)
                    .frame(width: 22, height: 22)
                    .overlay {
                        WebImage(
                            url: .init(string: followerImageURL),
                            options: [.scaleDownLargeImages, .retryFailed, .progressiveLoad]
                        )
                        .placeholder { Color.defaultBColorPlaceholder() }
                        .resizable()
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
            if followersCount != .zero {
                _3Followers
            }
            
            Text("\(followersCount.intToKMString()) follower\(profileVM.getPlural())")
        }
        .registerProfileTapEventViewModifier(event: Profile_TapEventTypes.followers) {
            isPresentedSheet = true
            print("followers action got triggered...")
        }
        .sheet(isPresented: $isPresentedSheet) {
            Text("Followers Sheet is under construction.\nComing soon...")
                .multilineTextAlignment(.center)
                .presentationDragIndicator(.visible)
        }
        .onChange(of: isPresentedSheet) { profileVM.handleFollowersSheetChanges($1) }
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
            .lineLimit(1)
            .registerProfileTapEventViewModifier(event: Profile_TapEventTypes.link) {
                guard let urlString: String = linkURL,
                      let url: URL = .init(string: urlString) else { return }
                
                UIApplication.shared.open(url)
                print("link action got triggered...")
            }
    }
}
