//
//  ProfileCoverContentView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-26.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileCoverContentView: View {
    @EnvironmentObject private var profileNameGenderNJoinedDateVM: ProfileNameGenderNJoinedDateVM
    
    // MARK: - PARAMETER PROPERTIES
    let coverType: ProfileCoverTypes
    let coverPhotoURL: URL?
    let arrowIconAngle: CGFloat
    let arrowIconOpacity: CGFloat
    let progressIndicatorOpacity: CGFloat
    let subHeadlineText: String
    let coverExtraHeight: CGFloat
    let coverTextOffsetY: CGFloat
    let profilePhotoURL: URL?
    
    // MARK: - PRIVATE PROPERTIES
    let profileVM: ProfileViewModel = .shared
    
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
            profileVM.coverMaxExtraHeight -
            topToolbarStaticMidY +
            coverTextHeight/2
        )
    }
    
    // Profile Photo
    var profilePhotoOffsetY: CGFloat {
        profileVM.secondaryProfilePhotoFrameSize * profileVM.profilePhotoOffsetFraction
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
        ProfileCoverContentView(
            coverType: .photo,
            coverPhotoURL: .init(string: "https://scontent.fcmb12-1.fna.fbcdn.net/v/t39.30808-6/428378921_1244897360247264_364892912709717832_n.jpg?stp=cp6_dst-jpg&_nc_cat=107&ccb=1-7&_nc_sid=783fdb&_nc_eui2=AeH7JFeN8qN22XlIyzzLGuBEO2wghYP6jM07bCCFg_qMzQ8uHwV4d6og5_TjSTKSD6tKsW-7cTrD_1PggLl5aIzX&_nc_ohc=8d-xKDes9ssAX-JCgn6&_nc_zt=23&_nc_ht=scontent.fcmb12-1.fna&oh=00_AfBn2lcCI3RxToCyWDuiygGmueeN0Yp7RslK5JqbmCBuXQ&oe=65EBA772"),
            arrowIconAngle: 0,
            arrowIconOpacity: 0,
            progressIndicatorOpacity: 0,
            subHeadlineText: "trusted by 123 people",
            coverExtraHeight: 0,
            coverTextOffsetY: 0,
            profilePhotoURL: .init(string: "https://scontent.fcmb6-1.fna.fbcdn.net/v/t39.30808-6/406267007_1193865175350483_2919837257462168261_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=efb6e6&_nc_eui2=AeGOldSQG18thI5isD-6m267s13hywPgx--zXeHLA-DH79wKxI1PB4CO7RN-2XCSBM3VDX0TVfwMcXViPTPbo71d&_nc_ohc=R1yaIRs2sSoAX8tysfD&_nc_zt=23&_nc_ht=scontent.fcmb6-1.fna&oh=00_AfDFKMOJPGHGDWEy0Ipu0LB6ufpX1GpUKWE4f-aKf7P7qg&oe=65ECD15C")
        )
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
            url: coverPhotoURL,
            options: [.highPriority, .scaleDownLargeImages]
        )
        .resizable()
        .defaultBColorPlaceholder
        .scaledToFill()
    }
    
    // MARK: - profilePhoto
    private var profilePhoto: some View {
        Circle()
            .fill(.tabBarNSystemBackground)
            .frame(
                width: profileVM.secondaryProfilePhotoFrameSize,
                height: profileVM.secondaryProfilePhotoFrameSize
            )
            .overlay {
                WebImage(
                    url: profilePhotoURL,
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
            .scaleEffect(profileVM.getProfilePhotoScale(), anchor: .bottomLeading)
            .offset(y: profilePhotoOffsetY)
            .padding(.leading)
            .opacity(profileVM.getCoverProfilePhotoOpacity())
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
            Text(profileNameGenderNJoinedDateVM.name)
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
    
    // MARK: - FUNCTIONS
    
    // MARK: - getCoverHeight
    private func getCoverHeight() -> CGFloat {
        /// this limits the cover height when it reaches its controlled minimum value.
        coverStaticHeight +
        (
            coverExtraHeight > profileVM.coverMaxExtraHeight
            ? coverExtraHeight
            : profileVM.coverMaxExtraHeight
        )
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
            ? coverTextOffsetY / coverTextMaxOffsetY * maxCoverBlur
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
        return 1 / (coverTextMaxOffsetY + preSmoothingValue) * coverTextOffsetY
    }
}
