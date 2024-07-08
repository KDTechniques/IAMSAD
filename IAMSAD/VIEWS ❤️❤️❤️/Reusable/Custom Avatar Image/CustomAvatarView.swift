//
//  CustomAvatarView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-10.
//

import SwiftUI

struct CustomAvatarView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    let avatar: AvatarModel?
    let imageSize: CGFloat?
    let color: Color
    let withBorder: Bool
    
    // MARK: - INITIALIZER
    init(
        avatar : AvatarModel?,
        imageSize: CGFloat? = nil,
        color: Color = .white,
        withBorder: Bool = false
    ) {
        self.avatar = avatar
        self.imageSize = imageSize
        self.color = color
        self.withBorder = withBorder
    }
    
    // MARK: - BODY
    var body: some View {
        if let avatar {
            CustomAvatarImageView(color: color, avatar: avatar, showBorder: withBorder)
                .imageSizeViewModifier(imageSize)
        } else {
            placeholderImage
        }
    }
}
// MARK: - PREVIEWS
#Preview("CustomAvatarView - with imageSize") {
    HStack {
        if let avatarsArray: [AvatarModel] = Avatar.shared.publicAvatarsDictionary[.random()] {
            ForEach(0..<5, id: \.self) {
                CustomAvatarView(avatar: avatarsArray[$0])
            }
        }
    }
    .previewViewModifier
}

#Preview("CustomAvatarView - No imageSize, but Frame Size") {
    if let avatarsArray: [AvatarModel] = Avatar.shared.publicAvatarsDictionary[.random()] {
        CustomAvatarView(avatar: avatarsArray[0])
            .frame(width: 100, height: 100)
            .previewViewModifier
    }
}

// MARK: - EXTENSIONS
extension CustomAvatarView {
    // MARK: - placeholderImage
    private var placeholderImage: some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .scaledToFit()
            .imageSizeViewModifier(imageSize)
            .foregroundStyle(Color.secondary.gradient)
            .symbolRenderingMode(.multicolor)
    }
}

extension View {
    // MARK: - imageSizeViewModifier
    @ViewBuilder
    fileprivate func imageSizeViewModifier(_ imageSize: CGFloat?) -> some View {
        if let imageSize {
            self.frame(width: imageSize, height: imageSize)
        } else { self }
    }
}
