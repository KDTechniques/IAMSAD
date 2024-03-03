//
//  ProfileCoverContentView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-26.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileCoverContentView: View {
    // MARK: - PROPERTIES
    // General
    let topToolbarLeadingItemStaticMaxX: CGFloat
    let topToolbarStaticMidY: CGFloat
    
    // Icons
    let iconFrameSize: CGFloat
    let iconExtraFrameHeight: CGFloat = 2
    var extendedIconFrameSize: CGFloat {
        iconFrameSize + iconExtraFrameHeight
    }
    
    // Cover
    let coverColor: Color = .accent
    let coverPhotoURL: URL?
    let coverType: ProfileCoverTypes
    let coverStaticHeight: CGFloat = 140
    let coverExtraHeight: CGFloat // +/- max value is controlled
    let coverMaxExtraHeight: CGFloat
    let maxCoverBlur: CGFloat = 8
    let safeBlurFrameSize: CGFloat = 20 /// to avoid image corners getting ugly when blurring
    
    // Arrow + Progress
    let arrowIconAngle: CGFloat
    let arrowIconOpacity: CGFloat
    let progressIndicatorOpacity: CGFloat
    
    // Profile Photo
    let profilePhotoFrameSize: CGFloat
    let profilePhotoSize: CGFloat
    let profilePhotoOffsetFraction: CGFloat
    var profilePhotoOffsetY: CGFloat { profilePhotoFrameSize * profilePhotoOffsetFraction }
    
    // Cover Text
    let profileName: String
    let subHeadlineText: String
    let coverTextExtraLeadingPadding: CGFloat = 20
    @State var coverTextHeight: CGFloat = .zero
    let coverTextOffsetY: CGFloat // +/- max value is controlled
    var coverTextMaxOffsetY: CGFloat {
        -(coverStaticHeight+coverMaxExtraHeight-topToolbarStaticMidY + coverTextHeight/2)
    }
    
    // MARK: - INITIALIZER
    init(
        profileName: String,
        subHeadlineText: String,
        topToolbarLeadingItemStaticMaxX: CGFloat,
        topToolbarStaticMidY: CGFloat,
        coverTextOffsetY: CGFloat,
        iconFrameSize: CGFloat,
        coverPhotoURL: URL?,
        coverType: ProfileCoverTypes,
        coverMaxExtraHeight: CGFloat,
        coverExtraHeight: CGFloat,
        arrowIconAngle: CGFloat,
        arrowIconOpacity: CGFloat,
        progressIndicatorOpacity: CGFloat,
        profilePhotoFrameSize: CGFloat,
        profilePhotoSize: CGFloat,
        profilePhotoOffsetFraction: CGFloat
    ) {
        self.profileName = profileName
        self.subHeadlineText = subHeadlineText
        self.topToolbarLeadingItemStaticMaxX = topToolbarLeadingItemStaticMaxX
        self.topToolbarStaticMidY = topToolbarStaticMidY
        self.coverTextOffsetY = coverTextOffsetY
        self.iconFrameSize = iconFrameSize
        self.coverPhotoURL = coverPhotoURL
        self.coverType = coverType
        self.coverMaxExtraHeight = coverMaxExtraHeight
        self.coverExtraHeight = coverExtraHeight
        self.arrowIconAngle = arrowIconAngle
        self.arrowIconOpacity = arrowIconOpacity
        self.progressIndicatorOpacity = progressIndicatorOpacity
        self.profilePhotoFrameSize = profilePhotoFrameSize
        self.profilePhotoSize = profilePhotoSize
        self.profilePhotoOffsetFraction = profilePhotoOffsetFraction
    }
    
    // MARK: - BODY
    var body: some View {
        Group {
            switch coverType {
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
        .overlay(alignment: .bottomLeading) { profilePhoto }
    }
}

// MARK: - PREVIEWS
#Preview("ProfileCoverContentView") {
    NavigationStack {
        ProfileCoverContentView(
            profileName: "Kavinda Dilshan",
            subHeadlineText: "trusted by 11 people",
            topToolbarLeadingItemStaticMaxX: 48,
            topToolbarStaticMidY: 75.66,
            coverTextOffsetY: -100, // +/- max value is controlled
            iconFrameSize: 14,
            coverPhotoURL: URL(string: "https://www.tomerazabi.com/wp-content/uploads/2020/12/IMG_7677-7751-1000px-SJPEG-V3.jpg"),
            coverType: .photo,
            coverMaxExtraHeight: -43,
            coverExtraHeight: 0, // +/- max value is controlled
            arrowIconAngle: .zero,
            arrowIconOpacity: 1.0,
            progressIndicatorOpacity: 1.0,
            profilePhotoFrameSize: 75,
            profilePhotoSize: 75 - 7,
            profilePhotoOffsetFraction: 1 - 1/3
        )
        .frame(height: screenHeight, alignment: .top)
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ToolbarTopLeadingItemView(
                    topToolbarLeadingItemStaticMaxX: .constant(0),
                    iconFrameSize: 14,
                    buttonType: .lockButton
                )
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                ToolbarTopTrailingItemsView(
                    topToolbarStaticMidY: .constant(.zero),
                    topToolbarStaticMaxY: .constant(.zero),
                    iconFrameSize: 14,
                    buttonType: .settingsButton
                )
            }
        }
    }
}

enum ProfileCoverTypes {
    case photo, color
}

// MARK: - EXTENSIONS
extension ProfileCoverContentView {
    // MARK: - coverPhoto
    private var coverPhoto: some View {
        WebImage(
            url: coverPhotoURL,
            options: [.highPriority, .scaleDownLargeImages]
        )
        .resizable()
        .placeholder { Color(uiColor: .systemGray6) }
        .scaledToFill()
    }
    
    // MARK: - arrowIcon
    private var arrowIcon: some View {
        Image(systemName: "arrow.down")
            .resizable()
            .scaledToFit()
            .fontWeight(.medium)
            .rotationEffect(.degrees(arrowIconAngle))
            .foregroundStyle(.white)
            .opacity(arrowIconOpacity)
    }
    
    // MARK: - progressIndicator
    private var progressIndicator: some View {
        ProgressView()
            .tint(.white)
            .opacity(progressIndicatorOpacity)
    }
    
    // MARK: - coverText
    @MainActor
    private var coverText: some View {
        VStack(alignment: .leading, spacing: -5) {
            Text(profileName)
                .font(.title3.weight(.heavy))
            
            Text(subHeadlineText)
                .font(.footnote)
        }
        .foregroundStyle(.white)
        .padding(.leading, topToolbarLeadingItemStaticMaxX + coverTextExtraLeadingPadding)
        .geometryReaderDimensionViewModifier($coverTextHeight, dimension: .height)
        .offset(y: coverTextHeight)
        .offset(y: getCoverTextOffset())
        .opacity(getCoverTextOpacity())
    }
    
    // MARK: - profilePhoto
    private var profilePhoto: some View {
        Circle()
            .fill(.tabBarNSystemBackground)
            .frame(width: profilePhotoFrameSize, height: profilePhotoFrameSize)
            .overlay {
                Image(.profilePhoto)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(
                        width: profilePhotoSize,
                        height: profilePhotoSize
                    )
            }
            .scaleEffect(getProfilePhotoScale(), anchor: .bottomLeading)
            .offset(y: profilePhotoOffsetY)
            .padding(.leading)
            .opacity(getProfilePhotoOpacity())
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - getCoverHeight
    private func getCoverHeight() -> CGFloat {
        /// this limits the cover height when it reaches its controlled minimum value.
        coverStaticHeight +
        (coverExtraHeight > coverMaxExtraHeight ? coverExtraHeight : coverMaxExtraHeight)
    }
    
    // MARK: - getCoverBlurOnScrollDown
    private func getCoverBlurOnScrollDown() -> CGFloat {
        let maxBlurHeight: CGFloat = 30
        
        if coverExtraHeight > 0 {
            return coverExtraHeight > maxBlurHeight
            ? maxCoverBlur
            : coverExtraHeight/maxBlurHeight*maxCoverBlur
        }
        
        return .zero
    }
    
    // MARK: - getCoverBlurOnScrollUp
    private func getCoverBlurOnScrollUp() -> CGFloat {
        if coverTextOffsetY < 0 {
            return coverTextOffsetY > coverTextMaxOffsetY
            ? coverTextOffsetY/coverTextMaxOffsetY*maxCoverBlur
            : maxCoverBlur
        }
        
        return 0
    }
    
    // MARK: -  getCOverTextOffset
    private func getCoverTextOffset() -> CGFloat {
        coverTextOffsetY > coverTextMaxOffsetY
        ? (coverTextOffsetY < 0) ? coverTextOffsetY : .zero
        : coverTextMaxOffsetY
    }
    
    // MARK: - getCoverTextOpacity
    private func getCoverTextOpacity() -> CGFloat {
        let preSmoothingValue: CGFloat = 10 /// this will give little bit more prior opacity before offset hits max offset Y.
        return 1/(coverTextMaxOffsetY+preSmoothingValue)*coverTextOffsetY
    }
    
    // MARK: - getProfilePhotoOpacity
    private func getProfilePhotoOpacity() -> CGFloat {
        coverExtraHeight <= coverMaxExtraHeight ? 0 : 1
    }
    
    // MARK: - getProfilePhotoScale
    private func getProfilePhotoScale() -> CGFloat {
        let calculation1: CGFloat = 1 - profilePhotoOffsetFraction
        let calculation2: CGFloat = coverExtraHeight/coverMaxExtraHeight*calculation1
        let calculation3: CGFloat = 1 - (calculation2 >= .zero ? calculation2 : .zero)
        
        return calculation3 > .zero ? calculation3 : .zero
    }
}
