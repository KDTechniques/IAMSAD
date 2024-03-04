//
//  ProfileGeneralButtonView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI

struct ProfileGeneralButtonView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var profileVM: ProfileViewModel
    
    let buttonType: ProfileGeneralButtonTypes
    
    // MARK: - INITIALIZER
    init(buttonType: ProfileGeneralButtonTypes) {
        self.buttonType = buttonType
    }
    
    // MARK: - BODY
    var body: some View {
        Text(buttonType.rawValue.capitalized)
            .font(.footnote.weight(.semibold))
            .foregroundStyle(Color.primary)
            .frame(width: 130, height: 32)
            .background(.clear)
            .clipShape(.rect(cornerRadius: 9))
            .background(
                RoundedRectangle(cornerRadius: 9)
                    .stroke(Color(uiColor: .systemGray4), lineWidth: 1)
            )
            .registerProfileTapEvent(event: .general) {
                // follow/unfollow/edit profile action goes here...
                print("general - follow/unfollow/edit profile action got triggered...")
            }
    }
}

// MARK: - PREVIEWS
#Preview("ProfileGeneralButtonView") {
    ProfileGeneralButtonView(buttonType: .editProfile)
        .previewViewModifier
}
