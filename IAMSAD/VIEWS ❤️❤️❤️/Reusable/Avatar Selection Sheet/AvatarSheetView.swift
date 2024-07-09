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
            View_1() /// For Larger Screen Models (ex: iPhone 15 Pro Max)
            View_2() /// For Smaller Screen Models (ex: iPhone SE3)
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

// MARK: - SUBVIEWS

// MARK: - View_1
fileprivate struct View_1: View {
    // MARK: - BODY
    var body: some View {
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
    }
}

// MARK: - View_2
fileprivate struct View_2: View {
    // MARK: - PROPERTIES
    @State private var showDivider: Bool = false
    let scrollContentTopPadding: CGFloat = 15
    
    // MARK: - BODY
    var body: some View {
        VStack {
            AvatarSheetHeaderTitleView()
            AvatarSheetPreviewImageView()
            
            VStack(spacing: 0) {
                HidableDividerView(showDivider: showDivider)
                    .padding(.horizontal, 20)
                
                ScrollView(.vertical, showsIndicators: false) {
                    AvatarSelectionView()
                        .padding(.top, scrollContentTopPadding)
                    
                    AvatarBackgroundColorSelectionView()
                        .padding(.bottom, 20)
                }
                .onScrollGeometryChange(for: Bool.self) { geo in
                    geo.contentOffset.y > scrollContentTopPadding
                } action: {
                    showDivider = $1
                }
                
            }
        }
    }
}
