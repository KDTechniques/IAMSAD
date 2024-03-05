//
//  ProfileShareButtonView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI

struct ProfileShareButtonView: View {
    // MARK: - BODY
    var body: some View {
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
            .registerProfileTapEvent(event: .share) {
                // share action goes here...
                print("share action got triggered...")
            }
        //            .background(Color.debug)
    }
}

// MARK: - PREVIEWS
#Preview("ProfileShareButtonView") {
    ProfileShareButtonView()
        .previewViewModifier
}
