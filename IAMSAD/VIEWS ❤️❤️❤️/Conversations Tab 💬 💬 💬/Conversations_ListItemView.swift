//
//  Conversations_ListItemView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-18.
//

import SwiftUI
import SDWebImageSwiftUI

struct Conversations_ListItemView: View {
    // MARK: - PROPERTIES
    let accountType: AccountTypes
    let avatar: AvatarModel?
    let imageURL: URL?
    let name: String
    let badgeType: VerifiedBadgeTypes?
    let time: String
    let text: String
    let conversationType: ConversationTypes
    
    let imageSize: CGFloat = 56
    let badgeSize: CGFloat = 15
    
    // MARK: - INITIALIZER
    init(
        accountType:AccountTypes,
        avatar: AvatarModel? = nil,
        imageURL: URL?,
        name: String,
        badgeType: VerifiedBadgeTypes? = nil,
        time: String,
        text: String,
        conversationType: ConversationTypes
    ) {
        self.accountType = accountType
        self.avatar = avatar
        self.imageURL = imageURL
        self.name = name
        self.badgeType = badgeType
        self.time = time
        self.text = text
        self.conversationType = conversationType
    }
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 12) {
            image
            
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    HStack(spacing: 4) {
                        nameText
                        badge
                    }
                    
                    Spacer()
                    
                    timeText
                }
                
                HStack(alignment: .bottom) {
                    messageText
                    Spacer()
                    flag
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.trailing, -5)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_ListItemView") {
    let url: URL? = .init(string: "https://picsum.photos/id/\(Int.random(in: 1...500))/300")
    
    return Group {
        if let avatar: AvatarModel = Avatar.shared.publicAvatarsDictionary[.random()]?.first {
            Conversations_ListItemView(
                accountType: .random(),
                avatar: avatar,
                imageURL: url,
                name: "Deepashika Sajeewanie",
                badgeType: .blue,
                time: "6:24 PM",
                text: "Don't you worry okay, i will help you go through this. Leave a message if you need me anytime. I'll get back to you as soon as i can.",
                conversationType: .conversationOnPost(isOnMyPost: true)
            )
            .padding(.horizontal)
            .previewViewModifier
        }
    }
}

// MARK: - EXTENSIONS
extension Conversations_ListItemView {
    // MARK: - image
    @ViewBuilder
    private var image: some View {
        Group {
            switch accountType {
            case .personal:
                if let imageURL {
                    WebImage(
                        url: imageURL,
                        options: [.scaleDownLargeImages, .retryFailed, .progressiveLoad]
                    )
                    .placeholder { Color.defaultBColorPlaceholder() }
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                } else {
                    CustomNoProfileImageView()
                }
                
            case .anonymous:
                if let avatar {
                    CustomAvatarImageView(avatar: avatar, borderSize: 1.5)
                } else {
                    CustomNoProfileImageView()
                }
            }
        }
        .frame(width: imageSize, height: imageSize)
    }
    
    // MARK: - nameText
    private var nameText: some View {
        Text(name)
            .font(.headline)
            .lineLimit(1)
    }
    
    // MARK: - badge
    @ViewBuilder
    private var badge: some View {
        if let badgeType = badgeType {
            Image(systemName: "checkmark.seal.fill")
                .resizable()
                .scaledToFit()
                .frame(width: badgeSize, height: badgeSize)
                .fontWeight(.semibold)
                .foregroundStyle(badgeType == .blue ? .cyan : .orange)
        }
    }
    
    // MARK: - timeText
    private var timeText: some View {
        Text(time)
            .font(.subheadline)
            .foregroundStyle(.secondary)
    }
    
    // MARK: - messageText
    private var messageText: some View {
        Text(text)
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .lineLimit(2)
    }
    
    // MARK: - flag
    @ViewBuilder
    private var flag: some View {
        if conversationType == .conversationOnPost(isOnMyPost: true) {
            Text("on my post")
                .font(.footnote)
                .padding(.vertical, 2)
                .padding(.horizontal, 8)
                .background(Color(uiColor: .systemGray5))
                .clipShape(.rect(cornerRadius: 5))
        }
    }
}
