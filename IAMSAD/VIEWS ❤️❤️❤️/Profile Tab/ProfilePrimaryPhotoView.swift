//
//  ProfilePrimaryPhotoView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI

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
                Image(.profilePhoto)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(
                        width: profileVM.primaryProfilePhotoSize,
                        height: profileVM.primaryProfilePhotoSize
                    )
            }
            .opacity(profileVM.getProfilePhotoOpacity())
    }
}

// MARK: - PREVIEWS
#Preview {
    ProfilePrimaryPhotoView()
        .previewViewModifier
}
