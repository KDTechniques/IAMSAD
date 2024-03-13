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
    let isScrolling: Bool
    
    // MARK: - INITITIALIZER
    init(bioText: String, isScrolling: Bool) {
        self.bioText = bioText
        self.isScrolling = isScrolling
    }
    
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
                    .moreTapRegistration(isScrolling: isScrolling)
            }
            .font(.subheadline)
        }
    }
}

// MARK: - PREVIEWS
#Preview("Profile_BioView") {
    Profile_BioView(
        bioText: "Sajee's Hubby 👩🏻‍❤️‍👨🏻\n1st Class Honours Graduate 👨🏻‍🎓\nUI/UX Designer/Engineer 👨🏻‍💻\nFront-End SwiftUI iOS Develoer 👨🏻‍💻",
        isScrolling: false
    )
    .previewViewModifier
}

// MARK: - EXTENSIONS
@MainActor
fileprivate extension View {
    // MARK: - moreTapRegistration
    func moreTapRegistration(isScrolling: Bool) -> some View {
        return Group {
            if isScrolling {
                self
            } else {
                self
                    .registerProfileTapEvent(event: Profile_TapEventTypes.more) {
                        // more action goes here...
                        print("more action got triggered...")
                    }
            }
        }
    }
}
