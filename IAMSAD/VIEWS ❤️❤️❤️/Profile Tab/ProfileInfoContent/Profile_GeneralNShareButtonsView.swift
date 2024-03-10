//
//  Profile_GeneralNShareButtonsView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI

struct Profile_GeneralNShareButtonsView: View {
    // MARK: - PROPERTIES
    let buttonType: ProfileGeneralButtonTypes
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 15) {
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
                .registerProfileTapEvent(event: Profile_TapEventTypes.general) {
                    // follow/unfollow/edit profile action goes here...
                    print("general - follow/unfollow/edit profile action got triggered...")
                }
            
            Circle()
                .stroke(Color(uiColor: .systemGray4), lineWidth: 1)
                .frame(width: 32, height: 32)
                .overlay {
                    Image(.share)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .padding(10)
                }
                .tint(.primary)
                .registerProfileTapEvent(event: Profile_TapEventTypes.share) {
                    // share action goes here...
                    print("share action got triggered...")
                }
        }
    }
}

// MARK: - PREVIEWS
#Preview("Profile_GeneralNShareButtonsView") {
    Profile_GeneralNShareButtonsView(buttonType: .pending)
        .previewViewModifier
}
