//
//  AvatarImageView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-28.
//

import SwiftUI
import SDWebImageSwiftUI

struct AvatarImageView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    let color: Color
    let avatar: AvatarModel
    let showShadow: Bool
    
    @State private var state: AvatarStateTypes = .loading
    
    // MARK: - INITIALIZER
    init(color: Color = .white, avatar: AvatarModel, showShadow: Bool = true) {
        self.color = color
        self.avatar = avatar
        self.showShadow = showShadow
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
                WebImage(url: url, options: [.lowPriority])
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
                showShadow: showShadow,
                state: state
            )
            .allowsHitTesting(state == .success)
    }
}

// MARK: - PREVIEWS
#Preview("AvatarImageView") {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            HStack(spacing: 20) {
                AvatarImageView(avatar: Avatar.shared.publicAvatarsArray[0])
                
                AvatarImageView(avatar: Array(
                    Avatar
                        .shared
                        .publicAvatarsArray
                        .filter({ $0.collection == .animals })
                        .prefix(1)
                ).first!)
            }
            .padding(100)
        }
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension AvatarImageView {
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
        showShadow: Bool,
        state: AvatarStateTypes
    ) -> some View {
        if colorScheme == .light, showShadow, state != .failure {
            self
                .background(
                    Circle()
                        .stroke(.black.opacity(0.05), style: .init(
                            lineWidth: 3,
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
