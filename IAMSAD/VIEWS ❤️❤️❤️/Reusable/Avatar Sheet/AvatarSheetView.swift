//
//  AvatarSheetView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-09.
//

import SwiftUI

struct AvatarSheetView: View {
    // MARK: - PROPEORTIES
    @Environment(\.colorScheme) private var colorScheme
    @Environment(AvatarSheetVM.self) private var avatarSheetVM
    
    // MARK: - BODY
    var body: some View {
        ViewThatFits(in: .vertical) {
            VStack {
                sheetHeader
                avatarPreview
                AvatarSelectionView()
                
                Spacer()
                
                AvatarBackgroundColorSelectionView()
                    .padding(.bottom, 60)
            }
            
            VStack {
                sheetHeader
                avatarPreview
                
                VStack(spacing: 0) {
                    Divider()
                        .padding(.horizontal, 20)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        AvatarSelectionView()
                            .padding(.top)
                        
                        AvatarBackgroundColorSelectionView()
                            .padding(.bottom, 60)
                    }
                }
            }
        }
        .padding(.top)
        .overlay(alignment: .topTrailing) { topTrailingButton }
        .ignoresSafeArea()
    }
}

// MARK: - PREVIEWS
#Preview("OnboardingAvatarView") {
    OnboardingAvatarView()
        .previewViewModifier
}

#Preview("AvatarSheetView") {
    ScrollView(.vertical) {
        AvatarSheetView()
    }
    .scrollDisabled(true)
    .previewViewModifier
}

// MARK: - EXTENSIONS
@MainActor
extension AvatarSheetView {
    // MARK: - sheetHeader
    private var sheetHeader: some View {
        Text("Pick Your Avatar")
            .font(.headline)
            .frame(maxWidth: .infinity)
    }
    
    // MARK: - avatarPreview
    private var avatarPreview: some View {
        CustomAvatarView(
            avatar: avatarSheetVM.selectedAvatar,
            imageSize: 80,
            color: Color(
                hue: avatarSheetVM.selectedBackgroundColor.hue,
                saturation: avatarSheetVM.selectedBackgroundColor.saturation,
                brightness: avatarSheetVM.selectedBackgroundColor.brightness
            )
        )
        .padding()
    }
    
    // MARK: - topTrailingButton
    private var topTrailingButton: some View {
        Button { avatarSheetVM.isPresentedAvatarSheet = false } label: {
            Text("Done")
                .fontWeight(.semibold)
                .foregroundStyle(.accent)
                .padding()
        }
    }
}
