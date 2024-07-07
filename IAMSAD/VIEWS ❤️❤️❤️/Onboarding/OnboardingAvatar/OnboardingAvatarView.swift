//
//  OnboardingAvatarView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-09.
//

import SwiftUI
import SDWebImageSwiftUI

struct OnboardingAvatarView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var avatarSheetVM: AvatarSheetVM
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                OnboardingTitleTextView(text: "Pick Your Avatar")
                avatarImageNButton
                preview
                list
            }
            .padding(.vertical, 50)
        }
        .sheet(isPresented: $avatarSheetVM.isPresentedAvatarSheet) { AvatarSheetView() }
    }
}

// MARK: - PREVIEWS
#Preview("OnboardingAvatarView") {
    OnboardingAvatarView()
        .previewViewModifier
}

// MARK: - EXTENSIONS
@MainActor
extension OnboardingAvatarView {
    // MARK: - avatarImage
    private var avatarImageNButton: some View {
        VStack {
            CustomAvatarView(
                avatar: avatarSheetVM.selectedAvatar,
                imageSize: 100,
                color: Color(
                    hue: avatarSheetVM.selectedBackgroundColor.hue,
                    saturation: avatarSheetVM.selectedBackgroundColor.saturation,
                    brightness: avatarSheetVM.selectedBackgroundColor.brightness
                )
            )
            .shadow(color: .black.opacity(0.1), radius: 3)
            
            Button {
                avatarSheetVM.isPresentedAvatarSheet = true
            } label: {
                Text("Change")
                    .font(.subheadline)
            }
        }
        .padding()
    }
    
    // MARK: - preview
    private var preview: some View {
        VStack(alignment: .leading) {
            Text("Preview")
                .font(.footnote.weight(.medium))
                .foregroundStyle(.secondary)
            
            
            HStack(alignment: .top) {
                CustomAvatarView(
                    avatar: avatarSheetVM.selectedAvatar,
                    imageSize: 60,
                    color: Color(
                        hue: avatarSheetVM.selectedBackgroundColor.hue,
                        saturation: avatarSheetVM.selectedBackgroundColor.saturation,
                        brightness: avatarSheetVM.selectedBackgroundColor.brightness
                    )
                )
                
                VStack(alignment: .leading) {
                    Text("@Beauty_Queen65 . 20m")
                        .font(.subheadline.weight(.semibold))
                    
                    Text("Female . 27")
                        .foregroundStyle(.secondary)
                        .font(.caption.weight(.medium))
                    
                    Text("I'm feeling overwhelmed with work and struggling to maintain a healthy work-life balance. Can anyone share tips on managing stress and finding time for personal well-being?")
                        .font(.subheadline)
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color(uiColor: .systemGray6))
            .clipShape(.rect(cornerRadius: 15))
        }
        .padding(.vertical)
        .padding(.horizontal, 30)
    }
    
    // MARK: - list
    private var list: some View {
        OnboardingListView {
            OnboardingListItemView(
                imageName: "Receipt",
                text: "Your avatar will be used for anonymous posts only. You can always change it later."
            )
            
            OnboardingListItemView(
                imageName: "SeeNoEvilMonkey",
                text: "You can choose to upload a profile picture later in settings if you wish to reveal your identity."
            )
        }
        .padding(.top, 40)
    }
}
