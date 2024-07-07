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
                AvatarSheetHeaderTitleView()
                AvatarSheetPreviewImageView()
                AvatarSelectionView()
                
                Spacer()
                
                AvatarBackgroundColorSelectionView()
                    .padding(.bottom, 60)
            }
            
            VStack {
                AvatarSheetHeaderTitleView()
                AvatarSheetPreviewImageView()
                
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
        .overlay(alignment: .topTrailing) { AvatarSheetTopTrailingButtonView() }
        .ignoresSafeArea()
    }
}

// MARK: - PREVIEWS
#Preview("AvatarSheetView") {
    ScrollView(.vertical) {
        AvatarSheetView()
    }
    .scrollDisabled(true)
    .previewViewModifier
}

#Preview("OnboardingAvatarView") {
    OnboardingAvatarView()
        .previewViewModifier
}
