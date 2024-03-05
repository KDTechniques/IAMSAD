//
//  ProfileCoverContentView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-26.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileCoverContentView: View {
    @EnvironmentObject private var profileCoverVM: ProfileCoverVM
    @EnvironmentObject private var profileNameGenderNJoinedDateVM: ProfileNameGenderNJoinedDateVM
    
    // MARK: - PROPERTIES
    
    // Toolbar
    @State var topToolbarStaticMidY: CGFloat = .zero
    @State var topToolbarStaticMaxY: CGFloat = .zero
    @State var topToolbarLeadingItemStaticMaxX: CGFloat = .zero
    let topToolbarIconsFrameSize: CGFloat = 14
    
    // Icons
    let iconExtraFrameHeight: CGFloat = 2
    var extendedIconFrameSize: CGFloat {
        topToolbarIconsFrameSize + iconExtraFrameHeight
    }
    
    // Cover
    let coverColor: Color = .accent
    let coverStaticHeight: CGFloat = 140
    let maxCoverBlur: CGFloat = 8
    let safeBlurFrameSize: CGFloat = 20 /// to avoid image corners getting ugly when blurring
    
    // Cover Text
    let coverTextExtraLeadingPadding: CGFloat = 20
    @State var coverTextHeight: CGFloat = .zero
    var coverTextMaxOffsetY: CGFloat {
        -(
            coverStaticHeight +
            ProfileCoverVM.shared.coverMaxExtraHeight -
            topToolbarStaticMidY +
            coverTextHeight/2
        )
    }
    
    // MARK: - BODY
    var body: some View {
        Group {
            switch profileCoverVM.coverType {
            case .photo: coverPhoto
            case .color: coverColor
            }
        }
        .frame(width: screenWidth + safeBlurFrameSize, height: getCoverHeight() + safeBlurFrameSize)
        .blur(radius: getCoverBlurOnScrollUp() + getCoverBlurOnScrollDown())
        .frame(width: screenWidth, height: getCoverHeight())
        .overlay {
            Group {
                arrowIcon
                progressIndicator
            }
            .frame(width: extendedIconFrameSize, height: extendedIconFrameSize)
        }
        .overlay(alignment: .bottomLeading) { coverText }
        .clipped()
        .overlay(alignment: .bottomLeading) { ProfilePhoto() }
        .ignoresSafeArea(edges: .top)
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
    }
}

// MARK: - PREVIEWS
#Preview("ProfileCoverContentView") {
    NavigationStack {
        ProfileCoverContentView()
            .frame(height: screenHeight, alignment: .top)
            .ignoresSafeArea()
    }
    .previewViewModifier
}

// MARK: - EXTENSIONS
extension ProfileCoverContentView {
    // MARK: - coverPhoto
    private var coverPhoto: some View {
        WebImage(
            url: profileCoverVM.coverPhotoURL,
            options: [.highPriority, .scaleDownLargeImages]
        )
        .resizable()
        .defaultBColorPlaceholder
        .scaledToFill()
    }
    
    // MARK: - arrowIcon
    private var arrowIcon: some View {
        Image(systemName: "arrow.down")
            .resizable()
            .scaledToFit()
            .fontWeight(.medium)
            .rotationEffect(.degrees(profileCoverVM.arrowIconAngle))
            .foregroundStyle(.white)
            .opacity(profileCoverVM.arrowIconOpacity)
    }
    
    // MARK: - progressIndicator
    private var progressIndicator: some View {
        ProgressView()
            .tint(.white)
            .opacity(profileCoverVM.progressIndicatorOpacity)
    }
    
    // MARK: - coverText
    @MainActor
    private var coverText: some View {
        VStack(alignment: .leading, spacing: -5) {
            Text(profileNameGenderNJoinedDateVM.name)
                .font(.title3.weight(.heavy))
            
            Text(profileCoverVM.subHeadlineText)
                .font(.footnote)
        }
        .foregroundStyle(.white)
        .padding(.leading, topToolbarLeadingItemStaticMaxX + coverTextExtraLeadingPadding)
        .geometryReaderDimensionViewModifier($coverTextHeight, dimension: .height)
        .offset(y: coverTextHeight)
        .offset(y: getCoverTextOffset())
        .opacity(getCoverTextOpacity())
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - getCoverHeight
    private func getCoverHeight() -> CGFloat {
        /// this limits the cover height when it reaches its controlled minimum value.
        coverStaticHeight +
        (
            profileCoverVM.coverExtraHeight > profileCoverVM.coverMaxExtraHeight
            ? profileCoverVM.coverExtraHeight
            : profileCoverVM.coverMaxExtraHeight
        )
    }
    
    // MARK: - getCoverBlurOnScrollDown
    private func getCoverBlurOnScrollDown() -> CGFloat {
        let maxBlurHeight: CGFloat = 30
        
        if profileCoverVM.coverExtraHeight > 0 {
            return profileCoverVM.coverExtraHeight > maxBlurHeight
            ? maxCoverBlur
            : profileCoverVM.coverExtraHeight/maxBlurHeight*maxCoverBlur
        }
        
        return .zero
    }
    
    // MARK: - getCoverBlurOnScrollUp
    private func getCoverBlurOnScrollUp() -> CGFloat {
        if profileCoverVM.coverTextOffsetY < 0 {
            return profileCoverVM.coverTextOffsetY > coverTextMaxOffsetY
            ? profileCoverVM.coverTextOffsetY / coverTextMaxOffsetY * maxCoverBlur
            : maxCoverBlur
        }
        
        return 0
    }
    
    // MARK: -  getCOverTextOffset
    private func getCoverTextOffset() -> CGFloat {
        profileCoverVM.coverTextOffsetY > coverTextMaxOffsetY
        ? (profileCoverVM.coverTextOffsetY < 0) ? profileCoverVM.coverTextOffsetY : .zero
        : coverTextMaxOffsetY
    }
    
    // MARK: - getCoverTextOpacity
    private func getCoverTextOpacity() -> CGFloat {
        let preSmoothingValue: CGFloat = 10 /// this will give little bit more prior opacity before offset hits max offset Y.
        return 1 / (coverTextMaxOffsetY + preSmoothingValue) * profileCoverVM.coverTextOffsetY
    }
}

// MARK: - SUBVIEWS
fileprivate struct ProfilePhoto: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var profileVM: ProfileViewModel
    @EnvironmentObject private var profileCoverVM: ProfileCoverVM
    
    var profilePhotoOffsetY: CGFloat {
        ProfileViewModel.shared.secondaryProfilePhotoFrameSize *
        ProfileViewModel.shared.profilePhotoOffsetFraction
    }
    
    // MARK: - BODY
    var body: some View {
        Circle()
            .fill(.tabBarNSystemBackground)
            .frame(
                width: profileVM.secondaryProfilePhotoFrameSize,
                height: profileVM.secondaryProfilePhotoFrameSize
            )
            .overlay {
                WebImage(
                    url: profileVM.profilePhotoURL,
                    options: [.highPriority, .scaleDownLargeImages]
                )
                .resizable()
                .defaultBColorPlaceholder
                .scaledToFill()
                .clipShape(Circle())
                .frame(
                    width: profileVM.secondaryProfilePhotoSize,
                    height: profileVM.secondaryProfilePhotoSize
                )
            }
            .scaleEffect(profileCoverVM.getProfilePhotoScale(), anchor: .bottomLeading)
            .offset(y: profilePhotoOffsetY)
            .padding(.leading)
            .opacity(profileCoverVM.getProfilePhotoOpacity())
    }
}
