//
//  ProfileCoverVM.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-05.
//

import Foundation

enum ProfileCoverTypes {
    case photo, color
}

@MainActor
final class ProfileCoverVM: ObservableObject {
    // MARK: - PROPERTIES
    
    // MARK: Cover
    let coverPhotoFrameStaticMaxY: CGFloat = 140
    let coverMaxExtraHeight: CGFloat = -43
    @Published var coverType: ProfileCoverTypes = .photo
    @Published var coverPhotoURL: URL? = .init(string: "https://scontent.fcmb12-1.fna.fbcdn.net/v/t39.30808-6/428378921_1244897360247264_364892912709717832_n.jpg?stp=cp6_dst-jpg&_nc_cat=107&ccb=1-7&_nc_sid=783fdb&_nc_eui2=AeH7JFeN8qN22XlIyzzLGuBEO2wghYP6jM07bCCFg_qMzQ8uHwV4d6og5_TjSTKSD6tKsW-7cTrD_1PggLl5aIzX&_nc_ohc=8d-xKDes9ssAX-JCgn6&_nc_zt=23&_nc_ht=scontent.fcmb12-1.fna&oh=00_AfBn2lcCI3RxToCyWDuiygGmueeN0Yp7RslK5JqbmCBuXQ&oe=65EBA772")
    @Published var coverExtraHeight: CGFloat = .zero
    
    // MARK: Cover Texts
    @Published var coverTextOffsetY: CGFloat = .zero
    @Published var subHeadlineText: String = "trusted by 123 people"
    
    // MARK: Refreshable
    @Published var arrowIconAngle: CGFloat = .zero
    @Published var arrowIconOpacity: CGFloat = .zero
    @Published var progressIndicatorOpacity: CGFloat = .zero
    
    // MARK: - Singleton
    static let shared: ProfileCoverVM = .init()
    
    // MARK: - INITIALIZER
    private init() {
        
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - setCoverOffsetY
    func setCoverTextOffsetY(_ value: CGFloat) {
        let triggerLine: CGFloat = coverPhotoFrameStaticMaxY + coverMaxExtraHeight
        coverTextOffsetY = value - triggerLine
    }
    
    // MARK: - getProfilePhotoScale
    func getProfilePhotoScale() -> CGFloat {
        let calculation1: CGFloat = 1 - ProfileViewModel.shared.profilePhotoOffsetFraction
        let calculation2: CGFloat = coverExtraHeight / coverMaxExtraHeight * calculation1
        let calculation3: CGFloat = 1 - (calculation2 >= .zero ? calculation2 : .zero)
        
        return calculation3 > .zero ? calculation3 : .zero
    }
    
    // MARK: - getProfilePhotoOpacity
    func getProfilePhotoOpacity() -> CGFloat {
        coverExtraHeight <= coverMaxExtraHeight ? 0 : 1
    }
}
