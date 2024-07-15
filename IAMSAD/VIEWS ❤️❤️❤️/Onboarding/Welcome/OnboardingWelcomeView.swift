//
//  OnboardingWelcomeView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-09.
//

import SwiftUI

struct OnboardingWelcomeView: View {
    // MARK: - PROPERTIES
    @State private var minY: CGFloat = 0
    @State private var maxY: CGFloat = 0
    @State private var showBackgroundEffect: Bool = false
    @State private var isDisabledScrolling: Bool = false
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                OnboardingWelcomeScrollContentView()
                    .padding(.vertical, 50)
                    .onGeometryChange(for: CGFloat.self) { geo in
                        geo.frame(in: .global).maxY
                    } action: { handleOnMaxY($0) }
            }
            .scrollDisabled(isDisabledScrolling)
            .safeAreaInset(edge: .bottom) {
                bottomButton
                    .onGeometryChange(for: CGFloat.self) { geo in
                        geo.frame(in: .global).minY
                    } action: { handleOnMinY($0) }
            }
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
    // MARK: - bottomButton
    private var bottomButton: some View {
        CustomStandardNavBottomButtonView(text: "Get Started") {
            OnboardingGenderNAgeView()
        }
        .padding(.top)
        .background(.ultraThinMaterial.opacity(showBackgroundEffect ? 1 : 0))
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - handleOnMaxY
    private func handleOnMaxY(_ maxY: CGFloat) {
        self.maxY = maxY
        showBackgroundEffect = maxY > minY
    }
    
    // MARK: - handleOnMinY
    /// For larger models like the iPhone 15 Pro Max, the background effect doesn't get triggered.
    /// That means the top part content isn't big enough to go under the bottom part.
    /// Therefore, we disable scrolling to avoid confusing the user and enhance the overall user experience.
    private func handleOnMinY(_ minY: CGFloat) {
        self.minY = minY
        DispatchQueue.main.async {
            isDisabledScrolling = maxY < minY
        }
    }
}
