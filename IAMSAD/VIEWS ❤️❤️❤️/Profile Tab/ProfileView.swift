//
//  ProfileView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-09.
//

import SwiftUI
import Combine

struct ProfileView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var profileVM: ProfileViewModel
    
    @State var topToolbarStaticMidY: CGFloat = .zero
    @State var topToolbarStaticMaxY: CGFloat = .zero
    @State var topToolbarLeadingItemStaticMaxX: CGFloat = .zero
    let topToolbarIconsFrameSize: CGFloat = 14
    let maxArrowOpacityCoverHeight: CGFloat = 10
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                ProfileBackgroundView()
                ProfileInfoView()
                
                Testing123(
                    contentOffset: $profileVM.contentOffset,
                    tapCoordinates: $profileVM.tapCoordinates,
                    topContentHeight: profileVM.profileContentHeight
                )
                
                ProfileCoverContentView(
                    profileName: "Kavinda Dilshan",
                    subHeadlineText: "trusted by 21 people",
                    topToolbarLeadingItemStaticMaxX: topToolbarLeadingItemStaticMaxX,
                    topToolbarStaticMidY: topToolbarStaticMidY,
                    coverTextOffsetY: profileVM.coverTextOffsetY,
                    iconFrameSize: topToolbarIconsFrameSize,
                    coverPhotoURL: URL(string: "https://www.tomerazabi.com/wp-content/uploads/2020/12/IMG_7677-7751-1000px-SJPEG-V3.jpg"),
                    coverType: .photo,
                    coverMaxExtraHeight: profileVM.coverMaxExtraHeight,
                    coverExtraHeight: -profileVM.throttledContentOffset.y,
                    arrowIconAngle: .zero, // add a property <------
                    arrowIconOpacity: .zero, // add a property <-----
                    progressIndicatorOpacity: .zero, // add a property <------
                    profilePhotoFrameSize: profileVM.secondaryProfilePhotoFrameSize,
                    profilePhotoSize: profileVM.secondaryProfilePhotoSize,
                    profilePhotoOffsetFraction: profileVM.profilePhotoOffsetFraction
                )
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    ToolbarTopLeadingItemView(
                        topToolbarLeadingItemStaticMaxX: $topToolbarLeadingItemStaticMaxX,
                        iconFrameSize: topToolbarIconsFrameSize,
                        buttonType: .lockButton
                    )
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    ToolbarTopTrailingItemsView(
                        topToolbarStaticMidY: $topToolbarStaticMidY,
                        topToolbarStaticMaxY: $topToolbarStaticMaxY,
                        iconFrameSize: topToolbarIconsFrameSize,
                        buttonType: .settingsButton
                    )
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }
}

// MARK: - PREVIEWS
#Preview("ProfileView") {
    ProfileView()
        .previewViewModifier
}
