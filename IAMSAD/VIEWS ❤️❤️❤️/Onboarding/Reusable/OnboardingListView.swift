//
//  OnboardingListView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-09.
//

import SwiftUI

struct OnboardingListView<T: View>: View {
    // MARK: - PROPERTIES
    let content: T
    
    // MARK: - INITIALIZER
    init(@ViewBuilder content: () -> T) { self.content = content() }
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 35) {
            content
        }
        .padding(.horizontal, 40)
    }
}

// MARK: - PREVIEWS
#Preview("OnboardingListView") {
    OnboardingListView {
        OnboardingListItemView(
            imageName: "ManTechnologist",
            text: "You can always change them later."
        )
        
        OnboardingListItemView(
            imageName: "ManTechnologist",
            text: "You can always change them later."
        )
        
        OnboardingListItemView(
            imageName: "ManTechnologist",
            text: "You can always change them later."
        )
    }
    .previewViewModifier
}
