//
//  Profile_ProfilePhotoView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-07.
//

import SwiftUI
import SDWebImageSwiftUI

@MainActor
struct Profile_ProfilePhotoView: View {
    // MARK: - PROPERTIES
    let profilePhotoURL: URL?
    let refreshBy: Any
    
    let profileVM: ProfileViewModel = .shared
    var profilePhotoOffsetY: CGFloat {
        profileVM.secondaryProfilePhotoFrameSize * profileVM.profilePhotoOffsetFraction
    }
    
    // MARK: - INITIALIZER
    init(profilePhotoURL: URL?, refreshBy: Any) {
        self.profilePhotoURL = profilePhotoURL
        self.refreshBy = refreshBy
    }
    
    // MARK: - BODY
    var body: some View {
        Circle()
            .fill(.tabBarNSystemBackground)
            .frame(
                width: profileVM.secondaryProfilePhotoFrameSize,
                height: profileVM.secondaryProfilePhotoFrameSize
            )
            .overlay {
                WebImage(
                    url: profilePhotoURL,
                    options: [.highPriority, .scaleDownLargeImages]
                )
                .resizable()
                .defaultBColorPlaceholder
                .scaledToFill()
                .clipShape(Circle())
                .frame(
                    width: profileVM.secondaryProfilePhotoSize,
                    height: profileVM.secondaryProfilePhotoSize
                )
            }
            .scaleEffect(profileVM.getProfilePhotoScale(), anchor: .bottomLeading)
            .offset(y: profilePhotoOffsetY)
            .padding(.leading)
            .opacity(profileVM.getCoverProfilePhotoOpacity())
    }
}

// MARK: - PREVIEWS
#Preview("Profile_ProfilePhotoView") {
    Profile_ProfilePhotoView(
        profilePhotoURL: .init(string: "https://scontent.fcmb6-1.fna.fbcdn.net/v/t39.30808-6/406267007_1193865175350483_2919837257462168261_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=efb6e6&_nc_eui2=AeGOldSQG18thI5isD-6m267s13hywPgx--zXeHLA-DH79wKxI1PB4CO7RN-2XCSBM3VDX0TVfwMcXViPTPbo71d&_nc_ohc=R1yaIRs2sSoAX8tysfD&_nc_zt=23&_nc_ht=scontent.fcmb6-1.fna&oh=00_AfDFKMOJPGHGDWEy0Ipu0LB6ufpX1GpUKWE4f-aKf7P7qg&oe=65ECD15C"),
        refreshBy: 0
    )
}
