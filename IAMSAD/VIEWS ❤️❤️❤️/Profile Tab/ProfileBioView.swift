//
//  ProfileBioView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI

struct ProfileBioView: View {
    // MARK: - PROPERTIES
    let bio: String
    
    // MARK: - INITIALIZER
    init(bio: String) {
        self.bio = bio
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .bottom) {
                Text(bio)
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
    }
}

// MARK: - PREVIEWS
#Preview("ProfileBioView") {
    ProfileBioView(bio: "Sajee's Hubby 👩🏻‍❤️‍👨🏻\n1st Class Honours Graduate 👨🏻‍🎓\nUI/UX Designer/Engineer 👨🏻‍💻\nFront-End SwiftUI iOS Develoer 👨🏻‍💻")
}
