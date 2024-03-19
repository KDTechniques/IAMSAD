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
            AvatarImageView(color: color, avatar: avatar, showBorder: withBorder)
                .imageSizeViewModifier(imageSize)
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .imageSizeViewModifier(imageSize)
                .foregroundStyle(Color.secondary.gradient)
                .symbolRenderingMode(.multicolor)
        }
    }
}
// MARK: - PREVIEWS
#Preview("CustomAvatarView - with imageSize") {
    HStack {
        ForEach(0..<5, id: \.self) {
            CustomAvatarView(avatar: Avatar.shared.publicAvatarsArray[$0])
        }
    }
    .previewViewModifier
}

#Preview("CustomAvatarView - No imageSize, but Frame Size") {
    CustomAvatarView(avatar: Avatar.shared.publicAvatarsArray[0])
        .frame(width: 100, height: 100)
        .previewViewModifier
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
