//
//  OnboardingWelcomeListItemView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-10.
//

import SwiftUI
import SDWebImageSwiftUI

struct OnboardingWelcomeListItemView: View {
    // MARK: - PROPERTIES
    let imageName: String
    let headline: String
    let subHeadline: String
    
    // MARK: - INITIALIZER
    init(imageName: String, headline: String, subHeadline: String) {
        self.imageName = imageName
        self.headline = headline
        self.subHeadline = subHeadline
    }
    
    // MARK: - BODY
    var body: some View {
        HStack {
            AnimatedImage(name: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 45, height: 45)
            
            VStack(alignment: .leading) {
                Text(headline)
                    .fontWeight(.semibold)
                
                Text(subHeadline)
                    .foregroundStyle(.secondary)
            }
            .font(.callout)
            .padding(.horizontal)
        }
    }
}

// MARK: - PREVIEWS
#Preview("OnboardingWelcomeListItemView") {
    OnboardingWelcomeListItemView(
        imageName: "SeeNoEvilMonkey",
        headline: "Your Privacy Matters",
        subHeadline: "It's 100% anonymous. You can choose when to reveal your identity."
    )
    .previewViewModifier
}
