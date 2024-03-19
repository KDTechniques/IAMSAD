//
//  Profile_PrimaryPhotoView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI
import SDWebImageSwiftUI

struct Profile_PrimaryPhotoView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var profileVM: ProfileVM
    
    // MARK: - BODY
    var body: some View {
        Circle()
            .fill(colorScheme == .dark ? .black : .white)
            .frame(
                width: profileVM.primaryProfilePhotoFrameSize,
                height: profileVM.primaryProfilePhotoFrameSize
            )
            .overlay {
                WebImage(
                    url: profileVM.profilePhotoURL,
                    options: [.highPriority, .scaleDownLargeImages, .retryFailed]
                )
                .resizable()
                .defaultBColorPlaceholder
                .scaledToFill()
                .clipShape(Circle())
                .frame(
                    width: profileVM.primaryProfilePhotoSize,
                    height: profileVM.primaryProfilePhotoSize
                )
                .presentStatusCircleHandler(
                    isPrimary: true,
                    isOnline: true,
                    color: colorScheme == .dark ? .black : .white
                )
            }
            .opacity(profileVM.getProfilePhotoOpacity())
    }
}

// MARK: - PREVIEWS
#Preview("Profile_PrimaryPhotoView") {
    Profile_PrimaryPhotoView()
        .previewViewModifier
}
