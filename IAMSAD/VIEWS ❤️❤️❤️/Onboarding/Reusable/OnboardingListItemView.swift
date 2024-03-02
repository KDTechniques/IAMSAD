//
//  OnboardingListItemView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-09.
//

import SwiftUI
import SDWebImageSwiftUI

struct OnboardingListItemView: View {
    // MARK: - PROPERTIES
    let imageName: String
    let text: String
    
    // MARK: - INITIALIZER
    init(imageName: String, text: String) {
        self.imageName  = imageName
        self.text       = text
    }
    
    // MARK: - BODY
    var body: some View {
        HStack {
            AnimatedImage(name: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 45, height: 45)
            
            Text(text)
                .font(.callout)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - PREVIEWS
#Preview("OnboardingListItemView") {
    OnboardingListItemView(
        imageName: "ManTechnologist",
        text: "You can always change them later."
    )
    .previewViewModifier
}
