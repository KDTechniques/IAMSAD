//
//  OnboardingUserNameView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-09.
//

import SwiftUI
import SDWebImageSwiftUI

struct OnboardingUserNameView: View {
    // MARK: - PROPERTIES
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                titleIcon
                OnboardingTitleTextView(text: "Create Your User Name")
                UserNameTextFieldView()
                list
            }
            .padding(.vertical, 50)
        }
    }
}

// MARK: - PREVIEWS
#Preview("OnboardingUserNameView") {
    OnboardingUserNameView()
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension OnboardingUserNameView {
    // MARK: - titleIcon
    private var titleIcon: some View {
        AnimatedImage(name: "CardIndex")
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
    }
    
    private var list: some View {
        OnboardingListView {
            OnboardingListItemView(
                imageName: "Skull",
                text: "Your username is unique and keeps you completely anonymous to others. You can always change it later."
            )
            
            OnboardingListItemView(
                imageName: "Receipt",
                text: "Your username will only be associated with anonymous posts."
            )
            
            OnboardingListItemView(
                imageName: "SeeNoEvilMonkey",
                text: "You can choose to share your name later in settings if you wish to reveal your identity."
            )
        }
        .padding(.top)
    }
}
