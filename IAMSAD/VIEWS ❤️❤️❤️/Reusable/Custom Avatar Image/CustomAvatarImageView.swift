//
//  CustomAvatarImageView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-28.
//

import SwiftUI
import SDWebImageSwiftUI

struct CustomAvatarImageView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    let color: Color
    let avatar: AvatarModel
    let showBorder: Bool
    let borderSize: CGFloat
    
    // MARK: - PRIVATE PROPERTIES
    @State private var state: AvatarStateTypes = .loading
    
    // MARK: - INITIALIZER
    init(
        color: Color = .white,
        avatar: AvatarModel,
        showBorder: Bool = true,
        borderSize: CGFloat = 3
    ) {
        self.color = color
        self.avatar = avatar
        self.showBorder = showBorder
        self.borderSize = borderSize
    }
    
    // MARK: - BODY
    var body: some View {
        let position: Alignment = avatar.position
        let url: URL? = Bundle.main.url(
            forResource: avatar.imageName,
            withExtension: "png"
        )
        
        Circle()
            .fill(getFillColor())
            .background(
                Circle()
                    .strokeBorder(.separator, style: .init(
                        lineWidth: 1.5,
                        lineCap: .round,
                        lineJoin: .round
                    ))
                    .opacity(state == .failure ? (colorScheme == .dark ? 1 : 0) : 0)
            )
            .overlay(alignment: position) {
                WebImage(url: url, options: [.scaleDownLargeImages, .retryFailed, .progressiveLoad])
                    .onProgress { _, _ in state = .loading }
                    .onSuccess { _, _, _ in state = .success }
                    .onFailure { _ in state = .failure }
                    .resizable()
                    .scaledToFit()
                    .imagePaddingViewModifier(position)
            }
            .clipShape(Circle())
            .shadowHandler(
                colorScheme: colorScheme,
                showBorder: showBorder,
                borderSize: borderSize,
                state: state
            )
            .allowsHitTesting(state == .success)
    }
}

// MARK: - PREVIEWS
#Preview("CustomAvatarImageView") {
    HStack(spacing: 20) {
        if let avatars: [AvatarModel] = Avatar.shared.publicAvatarsDictionary[.random()] {
            CustomAvatarImageView(avatar: avatars[Int.random(in: 0...20)], showBorder: true)
        }
        
        if let avatars: [AvatarModel] = Avatar.shared.publicAvatarsDictionary[.random()] {
            CustomAvatarImageView(avatar: avatars[Int.random(in: 0...20)], showBorder: false)
        }
    }
    .padding(100)
    .previewViewModifier
}

// MARK: - EXTENSIONS
extension CustomAvatarImageView {
    // MARK: - getFillColor
    private func getFillColor() -> Color {
        switch state {
        case .loading: Color(uiColor: .systemGray6)
        case .success: color
        case .failure: colorScheme == .dark ? .clear : .black.opacity(0.1)
        }
    }
}

extension View {
    // MARK: - imagePaddingViewModifier
    @ViewBuilder
    fileprivate func imagePaddingViewModifier(_ position: Alignment) -> some View {
        switch position {
        case .bottom :
            self.padding(.top, 8)
        case .center:
            self.padding(8)
        default: self
        }
    }
    
    // MARK: - shadowHandler
    @ViewBuilder
    fileprivate func shadowHandler(
        colorScheme: ColorScheme,
        showBorder: Bool,
        borderSize: CGFloat,
        state: AvatarStateTypes
    ) -> some View {
        if colorScheme == .light, showBorder, state != .failure {
            self
                .background(
                    Circle()
                        .stroke(Color(uiColor: .systemGray6), style: .init(
                            lineWidth: borderSize,
                            lineCap: .round,
                            lineJoin: .round
                        ))
                )
        } else { self }
    }
}

fileprivate enum AvatarStateTypes {
    case loading, success, failure
}
