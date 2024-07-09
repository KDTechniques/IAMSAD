//
//  OnboardingWelcomeScrollContentView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-10.
//

import SwiftUI

struct OnboardingWelcomeScrollContentView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - BODY
    var body: some View {
        VStack {
            logoImage
            welcomeText
            list
        }
    }
}

// MARK: - PREVIEWS
#Preview("OnboardingWelcomeScrollContentView") {
    OnboardingWelcomeScrollContentView()
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension OnboardingWelcomeScrollContentView {
    // MARK: - logoImage
    private var logoImage: some View {
        Image(colorScheme == .dark ? .logoDark : .logoLight)
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
            .shadow(color: .black.opacity(0.1), radius: 3)
    }
    
    // MARK: - welcomeText
    private var welcomeText: some View {
        Text("Welcome\nto IAMSAD")
            .multilineTextAlignment(.center)
            .font(.largeTitle.weight(.heavy))
    }
    
    // MARK: - list
    private var list: some View {
        VStack(alignment: .leading, spacing: 35) {
            OnboardingWelcomeListItemView(
                imageName: "FaceWithHeadBandage",
                headline: "Solve Personal Problems",
                subHeadline: "This platform is here to help with personal issues in relationships, family, health, finance, life events, mental health, career, and more."
            )
            
            OnboardingWelcomeListItemView(
                imageName: "SeeNoEvilMonkey",
                headline: "Your Privacy Matters",
                subHeadline: "It's 100% anonymous. You can choose when to reveal your identity."
            )
            
            OnboardingWelcomeListItemView(
                imageName: "Handshake",
                headline: "Collaborate with Others",
                subHeadline: "Ask for help when needed by posting and starting a conversation. You can also provide solutions to those who seek them."
            )
        }
        .padding(.horizontal, 40)
        .padding(.top, 30)
    }
}
