//
//  AvatarSheetView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-09.
//

import SwiftUI

struct AvatarSheetView: View {
    // MARK: - BODY
    var body: some View {
        ViewThatFits(in: .vertical) {
            // For Larger Screen Models (ex: iPhone 15 Pro Max)
            VStack {
                AvatarSheetHeaderTitleView()
                AvatarSheetPreviewImageView()
                AvatarSelectionView()
                
                Spacer()
                Spacer()
                
                AvatarBackgroundColorSelectionView()
                    .padding(.bottom)
                
                Spacer()
            }
            
            // For Smaller Screen Models (ex: iPhone SE3)
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
                            .padding(.bottom, 20)
                    }
                }
            }
        }
        .padding(.top)
        .overlay(alignment: .topTrailing) { AvatarSheetTopTrailingButtonView() }
    }
}

// MARK: - PREVIEWS
#Preview("AvatarSheetView") {
    Color.clear
        .sheet(isPresented: .constant(true)) { AvatarSheetView() }
        .previewViewModifier
}

#Preview("OnboardingAvatarView") {
    OnboardingAvatarView()
        .previewViewModifier
}
