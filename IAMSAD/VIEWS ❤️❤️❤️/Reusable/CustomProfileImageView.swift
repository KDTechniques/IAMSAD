//
//  CustomProfileImageView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-23.
//

import SwiftUI
import SDWebImageSwiftUI

struct CustomProfileImageView: View {
    // MARK: - PROERPTIES
    let accountType: AccountTypes
    let imageURL: URL?
    let avatar: AvatarModel?
    let imageSize: CGFloat
    let borderSize: CGFloat
    
    // MARK: - INITIALIZER
    init(
        accountType: AccountTypes,
        imageURL: URL? = nil,
        avatar: AvatarModel? = nil,
        imageSize: CGFloat,
        borderSize: CGFloat
    ) {
        self.accountType = accountType
        self.imageURL = imageURL
        self.avatar = avatar
        self.imageSize = imageSize
        self.borderSize = borderSize
    }
    
    // MARK: - BODY
    var body: some View {
        Group {
            switch accountType {
            case .personal:
                if let imageURL {
                    WebImage(
                        url: imageURL,
                        options: [.scaleDownLargeImages, .retryFailed, .progressiveLoad]
                    ) { $0 } placeholder: {
                        Color.defaultBColorPlaceholder(Color(uiColor: .systemGray5))
                    }
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                } else {
                    CustomNoProfileImageView()
                }
                
            case .anonymous:
                if let avatar {
                    CustomAvatarImageView(avatar: avatar, borderSize: borderSize)
                } else {
                    CustomNoProfileImageView()
                }
            }
        }
        .frame(width: imageSize, height: imageSize)
    }
}

// MARK: - PREVIEWS
#Preview("CustomProfileImageView") {
    if let avatar: AvatarModel = Avatar.shared.publicAvatarsDictionary[.random()]?.first {
        CustomProfileImageView(
            accountType: .random(),
            imageURL: .init(string: "https://picsum.photos/id/\(Int.random(in: 100...300))/150"),
            avatar: avatar,
            imageSize: 50,
            borderSize: 1.5
        )
    }
}
