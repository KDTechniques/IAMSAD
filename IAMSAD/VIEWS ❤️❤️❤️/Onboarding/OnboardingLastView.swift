//
//  OnboardingLastView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-16.
//

import SwiftUI
import SDWebImageSwiftUI

struct OnboardingLastView: View {
    // MARK: - BODY
    var body: some View {
        VStack {
            titleIcon
            OnboardingTitleTextView(text: "All Set")
            text
            
            Spacer()
        }
        .padding(.vertical, 50)
        .safeAreaInset(edge: .bottom) {
            CustomStandardPrimaryBottomButtonView(
                pText: "Done",
                showProgressIndicator: false) {
                    // switch to home using an if condition
                }
        }
    }
}

// MARK: - PREVIEWS
#Preview("OnboardingLastView") {
    OnboardingLastView()
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension OnboardingLastView {
    // MARK: - titleIcon
    private var titleIcon: some View {
        AnimatedImage(name: "ThumbsUpLightSkinTone")
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
    }
    
    // MARK: - text
    private var text: some View {
        VStack(spacing: 30) {
            Text("You're now a member of the IAMSAD community.")
            Text("Let's make the world a better place.")
        }
        .multilineTextAlignment(.center)
        .padding(.top, 5)
        .padding(.horizontal, 20)
    }
}
