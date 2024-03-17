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
    
    @State private var more: Bool = false
    let lineLimit: Int = 5
    
    // MARK: - INITITIALIZER
    init(bioText: String, isScrolling: Bool) {
        self.bioText = bioText
        self.isScrolling = isScrolling
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .bottom) {
                Text(bioText.truncateToLineLimit(lineLimit: more ? lineLimit : 4, dotsLimit: lineLimit))
                    .lineSpacing(5)
                    .lineLimit(lineLimit)
                
                if !more {
                    Text("more")
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                        .padding(.leading, 6)
                        .moreTapRegistration($more, isScrolling: isScrolling)
                }
            }
            .font(.subheadline)
        }
        .frame(maxWidth: screenWidth - 50, alignment: .leading)
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
    func moreTapRegistration(_ more: Binding<Bool>, isScrolling: Bool) -> some View {
        return Group {
            if isScrolling {
                self
            } else {
                self
                    .registerProfileTapEvent(event: Profile_TapEventTypes.more) {
                        more.wrappedValue = true
                        print("more action got triggered...")
                    }
            }
        }
    }
}
