//
//  ProfileViewModel.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-03.
//

import SwiftUI
import Combine

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
    let profileCoverVM: ProfileCoverVM = .shared
    
    @Published var tapRegisteredEventsArray: [TapRegisterModel<ProfileTabEventTypes>] = []
    @Published var tapCoordinates: CGPoint = .zero
    @Published var contentOffset: CGPoint = .zero
    @Published var throttledContentOffset: CGPoint = .zero
    @Published var profileContentHeight: CGFloat = .zero
    let horizontalTabsExtraTopPadding: CGFloat = 10
    var cancellable: Set<AnyCancellable> = []
    
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
    
    // MARK: Refreshable
    @Published var arrowDownAngle: CGFloat = .zero
    @Published var arrowDownOpacity: CGFloat = .zero
    @Published var progressIndicatorOpacity: CGFloat = .zero
    
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
                profileCoverVM.coverPhotoFrameStaticMaxY - profileCoverVM.coverMaxExtraHeight
                
                if newValue.y <= conditionValue {
                    throttledContentOffset = newValue
                    profileCoverVM.coverExtraHeight = -newValue.y
                } else {
                    throttledContentOffset.y = conditionValue
                    profileCoverVM.coverExtraHeight = -conditionValue
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
    
    // MARK: Profile Photo
    
    // MARK: - getProfilePhotoOpacity
    func getProfilePhotoOpacity() -> CGFloat {
        -contentOffset.y <= profileCoverVM.coverMaxExtraHeight ? 1 : 0
    }
}
