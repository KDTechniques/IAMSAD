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
    @State private var isDisabledScrolling: Bool = false
    
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
                    bottomPartMinY: minY,
                    topPartMaxY: $maxY,
                    showBackgroundEffect: $showBackgroundEffect
                )
            }
            .scrollDisabled(isDisabledScrolling)
            .safeAreaInset(edge: .bottom) {
                bottomButton
                    .bottomPartBackgroundEffectOnScrollViewModifier(bottomPartMinY: $minY)
            }
            .onChange(of: minY) { handleOnChangeMinY($1) }
        }
    }
}

// MARK: - PREVIEWS
#Preview("OnboardingWelcomeView") {
    OnboardingWelcomeView()
//        .previewViewModifier
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
    
    // MARK: - FUNCTIONS
    
    // MARK: - handleOnChangeMinY
    private func handleOnChangeMinY(_ minY: CGFloat) {
        /// `onChange` is needed even though the following condition is checked by the top part view modifier.
        /// This is because on larger models like the iPhone 15 Pro Max, the background effect gets triggered due to the bottom part appearing before the top part, leading to incorrect results on appear.
        /// So using `onChange` with `minY` corrects that issue.
        let boolean: Bool = maxY > minY
        showBackgroundEffect = boolean
        /// For larger models like the iPhone 15 Pro Max, the background effect doesn't get triggered.
        /// That means the top part content isn't big enough to go under the bottom part.
        /// Therefore, we disable scrolling to avoid confusing the user and enhance the overall user experience..
        isDisabledScrolling = !boolean
    }
}
