//
//  ProfilePrimaryPhotoView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfilePrimaryPhotoView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var profileVM: ProfileViewModel
    
    // MARK: - BODY
    var body: some View {
        Circle()
            .fill(.tabBarNSystemBackground)
            .frame(
                width: profileVM.primaryProfilePhotoFrameSize,
                height: profileVM.primaryProfilePhotoFrameSize
            )
            .overlay {
                WebImage(
                    url: profileVM.profilePhotoURL,
                    options: [.highPriority, .scaleDownLargeImages]
                )
                .resizable()
                .defaultBColorPlaceholder
                .scaledToFill()
                .clipShape(Circle())
                .frame(
                    width: profileVM.primaryProfilePhotoSize,
                    height: profileVM.primaryProfilePhotoSize
                )
            }
            .opacity(profileVM.getProfilePhotoOpacity())
//            .background(Color.debug)
    }
}

// MARK: - PREVIEWS
#Preview("ProfilePrimaryPhotoView") {
    ProfilePrimaryPhotoView()
        .previewViewModifier
}
