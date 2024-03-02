//
//  OnboardingTitleTextView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-09.
//

import SwiftUI

struct OnboardingTitleTextView: View {
    // MARK: - PROPERTIES
    let text: String
    
    // MARK: - INITIALIZER
    init(text: String) { self.text = text }
    
    // MARK: - BODY
    var body: some View {
        Text(text)
            .multilineTextAlignment(.center)
            .font(.title.weight(.heavy))
            .padding(.horizontal)
    }
}

// MARK: - PREVIEWS
#Preview("OnboardingTitleTextView") {
    OnboardingTitleTextView(text: "Create Your User Name")
        .previewViewModifier
}
