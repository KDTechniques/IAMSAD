//
//  OnboardingWelcomeView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-09.
//

import SwiftUI
import SDWebImageSwiftUI

struct OnboardingWelcomeView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var minY: CGFloat = 0
    @State private var maxY: CGFloat = 0
    @State private var showBackgroundEffect: Bool = false
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    logoImage
                    welcomeText
                    list
                }
                .padding(.vertical, 50)
                .topPartBackgroundEffectOnScrollViewModifier(
                    minY: minY,
                    maxY: $maxY,
                    showBackgroundEffect: $showBackgroundEffect
                )
            }
            .safeAreaInset(edge: .bottom) {
                bottomButton
                    .bottomPartBackgroundEffectOnScrollViewModifier(minY: $minY)
            }
            .onChange(of: minY) { showBackgroundEffect = maxY > $1 }
        }
    }
}

// MARK: - PREVIEWS
#Preview("OnboardingWelcomeView") {
    OnboardingWelcomeView()
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension OnboardingWelcomeView {
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
            onboardingListView(
                imageName: "FaceWithHeadBandage",
                headline: "Solve Personal Problems",
                subHeadline: "This platform is here to help with personal issues in relationships, family, health, finance, life events, mental health, career, and more."
            )
            
            onboardingListView(
                imageName: "SeeNoEvilMonkey",
                headline: "Your Privacy Matters",
                subHeadline: "It's 100% anonymous. You can choose when to reveal your identity."
            )
            
            onboardingListView(
                imageName: "Handshake",
                headline: "Collaborate with Others",
                subHeadline: "Ask for help when needed by posting and starting a conversation. You can also provide solutions to those who seek them."
            )
        }
        .padding(.horizontal, 40)
        .padding(.top, 30)
    }
    
    // MARK: - onboardingListView
    private func onboardingListView(
        imageName: String,
        headline: String,
        subHeadline: String
    ) -> some View {
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
    
    // MARK: - bottomButton
    private var bottomButton: some View {
        CustomStandardNavBottomButtonView(text: "Get Started") {
            OnboardingGenderNAgeView()
        }
        .padding(.top)
        .background(.ultraThinMaterial.opacity(showBackgroundEffect ? 1 : 0))
    }
}
