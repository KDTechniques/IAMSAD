//
//  Profile_SecondaryProfilePhotoView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-07.
//

import SwiftUI
import SDWebImageSwiftUI

struct Profile_SecondaryProfilePhotoView: View {
    // MARK: - PROPERTIES
    let profilePhotoURL: URL?
    let refreshBy: Any
    
    let profileVM: ProfileVM = .shared
    var profilePhotoOffsetY: CGFloat {
        profileVM.secondaryProfilePhotoFrameSize * profileVM.profilePhotoOffsetRatio
    }
    
    // MARK: - INITIALIZER
    init(profilePhotoURL: URL?, refreshBy: Any) {
        self.profilePhotoURL = profilePhotoURL
        self.refreshBy = refreshBy
    }
    
    // MARK: - BODY
    var body: some View {
        Circle()
            .fill(.colorScheme)
            .frame(
                width: profileVM.secondaryProfilePhotoFrameSize,
                height: profileVM.secondaryProfilePhotoFrameSize
            )
            .overlay {
                WebImage(
                    url: profilePhotoURL,
                    options: [.scaleDownLargeImages, .retryFailed, .progressiveLoad]
                )
                .placeholder { Color.defaultBColorPlaceholder() }
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(
                    width: profileVM.secondaryProfilePhotoSize,
                    height: profileVM.secondaryProfilePhotoSize
                )
                .presentStatusCircleHandlerViewModifier(isPrimary: false, isOnline: true)
            }
            .scaleEffect(profileVM.getProfilePhotoScale(), anchor: .bottomLeading)
            .offset(y: profilePhotoOffsetY)
            .padding(.leading)
            .opacity(profileVM.getCoverProfilePhotoOpacity())
    }
}

// MARK: - PREVIEWS
#Preview("Profile_SecondaryProfilePhotoView") {
    Profile_SecondaryProfilePhotoView(
        profilePhotoURL: .init(string: "https://img.freepik.com/free-photo/portrait-young-woman-with-natural-make-up_23-2149084907.jpg"),
        refreshBy: 0
    )
}
