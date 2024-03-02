//
//  OnboardingGenderNAgeView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-09.
//

import SwiftUI
import SDWebImageSwiftUI

struct OnboardingGenderNAgeView: View {
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                titleIcons
                OnboardingTitleTextView(text: "Your Gender and Age")
                GenderPickerView()
                AgePickerView()
                list
            }
            .padding(.vertical, 50)
        }
        .navigationBarBackButtonHidden()
    }
}

// MARK: - PREVIEWS
#Preview("OnboardingGenderNAgeView") {
    OnboardingGenderNAgeView()
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension OnboardingGenderNAgeView {
    // MARK: - titleIcons
    private var titleIcons: some View {
        HStack(alignment: .top) {
            AnimatedImage(name: "WomanDarkSkinToneRedHair")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .offset(y: -10)
            
            AnimatedImage(name: "ManMediumLightSkinToneCurlyHair")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .offset(y: 10)
        }
        .frame(height: 70)
    }
    
    // MARK: - list
    private var list: some View {
        OnboardingListView {
            OnboardingListItemView(
                imageName: "IndexPointingUp",
                text: "Your gender and age matter when other people want to give solutions or advice for your problems."
            )
            
            OnboardingListItemView(
                imageName: "ManTechnologist",
                text: "You can always change them later."
            )
        }
        .padding(.top)
    }
}

// MARK: - SUBVIEWS

// MARK: - GenderPickerView
struct GenderPickerView: View {
    // MARK: - PROPERTIES
    @State private var genderSelection: GenderTypes = .female
    
    // MARK: - BODY
    var body: some View {
        Picker("Your Gender", selection: $genderSelection) {
            ForEach(GenderTypes.allCases, id: \.self) {
                Text($0.rawValue)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
}

// MARK: - AgePickerView
struct AgePickerView: View {
    // MARK: - PROPERTIES
    @State private var ageSelection: Int = 18
    
    // MARK: - BODY
    var body: some View {
        Picker("Your Age", selection: $ageSelection) {
            ForEach(14...60, id: \.self) {
                Text("\($0)")
            }
        }
        .pickerStyle(.wheel)
        .frame(width: 200, height: 200)
        .padding(.vertical)
    }
}
