//
//  Profile_BioView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI

struct Profile_BioView: View {
    // MARK: - PROPERTIES
    let bioText: String
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .bottom) {
                Text(bioText)
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
#Preview("Profile_BioView") {
    Profile_BioView(bioText: "Sajee's Hubby 👩🏻‍❤️‍👨🏻\n1st Class Honours Graduate 👨🏻‍🎓\nUI/UX Designer/Engineer 👨🏻‍💻\nFront-End SwiftUI iOS Develoer 👨🏻‍💻")
        .previewViewModifier
}
