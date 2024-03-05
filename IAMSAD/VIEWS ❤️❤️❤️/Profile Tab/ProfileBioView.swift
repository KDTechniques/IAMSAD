//
//  ProfileBioView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI

struct ProfileBioView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var profileBioVM: ProfileBioVM
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .bottom) {
                Text(profileBioVM.bioText)
                    .lineSpacing(5)
                
                Text("more")
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                    .padding(.leading, 6)
                    .registerProfileTapEvent(event: .more) {
                        // more action goes here...
                        print("more action got triggered...")
                    }
            }
            .font(.subheadline)
        }
        //        .background(Color.debug)
    }
}

// MARK: - PREVIEWS
#Preview("ProfileBioView") {
    ProfileBioView()
        .previewViewModifier
}
