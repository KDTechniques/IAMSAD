//
//  Profile_CoverContentView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-26.
//

import SwiftUI
import SDWebImageSwiftUI

struct Profile_CoverContentView: View {
    @EnvironmentObject private var profileVM: ProfileViewModel
    
    // MARK: - BODY
    var body: some View {
        Group {
            switch profileVM.coverType {
            case .photo: Profile_CoverPhotoView(coverPhotoURL: profileVM.coverPhotoURL)
            case .color: profileVM.coverColor
            }
        }
        .frame(
            width: screenWidth + profileVM.safeBlurFrameSize,
            height: profileVM.getCoverHeight() + profileVM.safeBlurFrameSize
        )
        .blur(radius: profileVM.getCoverBlurOnScrollUp() + profileVM.getCoverBlurOnScrollDown())
        .frame(width: screenWidth, height: profileVM.getCoverHeight())
        .overlay {
            Group {
                Profile_ArrowIconView(
                    arrowIconAngle: profileVM.arrowIconAngle,
                    arrowIconOpacity: profileVM.arrowIconOpacity
                )
                
                Profile_ProgressIndicatorView(progressIndicatorOpacity: profileVM.progressIndicatorOpacity)
            }
            .frame(width: profileVM.extendedIconFrameSize, height: profileVM.extendedIconFrameSize)
        }
        .overlay(alignment: .bottomLeading) {
            Profile_CoverTextView(
                coverTextStaticHeight: $profileVM.coverTextStaticHeight,
                name: profileVM.name,
                subHeadlineText: profileVM.subHeadlineText,
                topToolbarLeadingItemStaticMaxX: profileVM.topToolbarLeadingItemStaticMaxX,
                refreshBy: profileVM.coverTextOffsetY
            )
        }
        .clipped()
        .overlay(alignment: .bottomLeading) {
            Profile_ProfilePhotoView(
                profilePhotoURL: profileVM.profilePhotoURL,
                refreshBy: profileVM.coverExtraHeight
            )
        }
        .ignoresSafeArea(edges: .top)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ToolbarTopLeadingItemView(
                    topToolbarLeadingItemStaticMaxX: $profileVM.topToolbarLeadingItemStaticMaxX,
                    iconFrameSize: profileVM.topToolbarIconsFrameSize,
                    buttonType: .lockButton
                )
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                ToolbarTopTrailingItemsView(
                    topToolbarStaticMidY: $profileVM.topToolbarStaticMidY,
                    topToolbarStaticMaxY: $profileVM.topToolbarStaticMaxY,
                    iconFrameSize: profileVM.topToolbarIconsFrameSize,
                    buttonType: .settingsButton
                )
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("Profile_CoverContentView") {
    NavigationStack {
        Profile_CoverContentView()
            .frame(height: screenHeight, alignment: .top)
            .ignoresSafeArea()
    }
    .previewViewModifier
}
