//
//  ProfileViewModel.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-03.
//

import SwiftUI
import Combine

enum ProfileCoverTypes {
    case photo, color
}

enum ProfileGeneralButtonTypes: String {
    case editProfile = "edit profile", follow, following, pending
}

enum ProfileTabEventTypes {
    case general, share, more, followers, link
}

@MainActor
final class ProfileViewModel: ObservableObject {
    // MARK: - PRORPERTIES
    
    // MARK: Common
    @Published var tapRegisteredEventsArray: [TapRegisterModel<ProfileTabEventTypes>] = []
    @Published var tapCoordinates: CGPoint = .zero
    @Published var contentOffset: CGPoint = .zero
    @Published var throttledContentOffset: CGPoint = .zero
    @Published var profileContentHeight: CGFloat = .zero
    let horizontalTabsExtraTopPadding: CGFloat = 10
    var cancellable: Set<AnyCancellable> = []
    
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
    
    // MARK: Profile Photo
    let profilePhotoOffsetFraction: CGFloat = 1 - 1/3
    // Secondary
    let secondaryProfilePhotoFrameSize: CGFloat = 75
    let secondaryProfilePhotoBorderSize: CGFloat = 7
    var secondaryProfilePhotoSize: CGFloat {
        secondaryProfilePhotoFrameSize - secondaryProfilePhotoBorderSize
    }
    // Primary
    var primaryProfilePhotoFrameSize: CGFloat {
        secondaryProfilePhotoFrameSize * profilePhotoOffsetFraction
    }
    var primaryProfilePhotoSize: CGFloat {
        secondaryProfilePhotoSize * profilePhotoOffsetFraction
    }
    @Published var profilePhotoURL: URL? = .init(string: "https://scontent.fcmb6-1.fna.fbcdn.net/v/t39.30808-6/406267007_1193865175350483_2919837257462168261_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=efb6e6&_nc_eui2=AeGOldSQG18thI5isD-6m267s13hywPgx--zXeHLA-DH79wKxI1PB4CO7RN-2XCSBM3VDX0TVfwMcXViPTPbo71d&_nc_ohc=R1yaIRs2sSoAX8tysfD&_nc_zt=23&_nc_ht=scontent.fcmb6-1.fna&oh=00_AfDFKMOJPGHGDWEy0Ipu0LB6ufpX1GpUKWE4f-aKf7P7qg&oe=65ECD15C")
    
    // MARK: Singleton
    static let shared: ProfileViewModel = .init()
    
    // MARK: - INITIALAIER
    init() {
        tapCoordinatesSubscriber()
        contentOffsetSubscriber()
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: Common
    
    // MARK: - contentOffsetSubscriber
    private func contentOffsetSubscriber() {
        $contentOffset
            .subscribe(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                guard let self = self else { return }
                
                let conditionValue: CGFloat = profileContentHeight -
                coverPhotoFrameStaticMaxY - coverMaxExtraHeight
                
                if newValue.y <= conditionValue {
                    throttledContentOffset = newValue
                    coverExtraHeight = -newValue.y
                } else {
                    throttledContentOffset.y = conditionValue
                    coverExtraHeight = -conditionValue
                }
            }
            .store(in: &cancellable)
    }
    
    // MARK: - registerEventCoordinates
    func registerEventCoordinates(
        event: ProfileTabEventTypes,
        frame: CGRect,
        action: @escaping ()->()
    ) {
        guard let index: Int = tapRegisteredEventsArray.firstIndex(where: { $0.event == event}) else {
            tapRegisteredEventsArray.append(.init(
                frame: frame,
                event: event,
                action: action
            ))
            
            return
        }
        
        tapRegisteredEventsArray[index].setFrame(frame)
    }
    
    // MARK: - executeTapEvent
    func executeTapEvent(_ coordinates: CGPoint) {
        let x: CGFloat = coordinates.x
        let y: CGFloat = coordinates.y
        
        guard let item: TapRegisterModel = tapRegisteredEventsArray.first(where: {
            ($0.frame.minX <= x && $0.frame.maxX >= x) && ($0.frame.minY <= y && $0.frame.maxY >= y)
        }) else { return }
        
        item.action()
    }
    
    // MARK: - tapCoordinatesSubscriber
    func tapCoordinatesSubscriber() {
        $tapCoordinates
            .sink { [weak self] newValue in
                guard let self = self else { return }
                executeTapEvent(newValue)
            }
            .store(in: &cancellable)
    }
    
    // MARK: - setProfileContentHeight
    func setProfileContentHeight(_ value: CGFloat) {
        profileContentHeight = value + horizontalTabsExtraTopPadding
    }
    
    // MARK: - Profile Cover
    
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
    
    // MARK: - getCoverProfilePhotoOpacity
    func getCoverProfilePhotoOpacity() -> CGFloat {
        coverExtraHeight <= coverMaxExtraHeight ? 0 : 1
    }
    
    // MARK: Profile Photo
    
    // MARK: - getProfilePhotoOpacity
    func getProfilePhotoOpacity() -> CGFloat {
        -contentOffset.y <= coverMaxExtraHeight ? 1 : 0
    }
}
