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
    
    // MARK: Cover
    let coverPhotoFrameStaticMaxY: CGFloat = 140
    let coverMaxExtraHeight: CGFloat = -43
    @Published var coverTextOffsetY: CGFloat = .zero
    
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
    func contentOffsetSubscriber() {
        $contentOffset
            .subscribe(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                guard let self = self else { return }
                let conditionValue: CGFloat = profileContentHeight - coverPhotoFrameStaticMaxY - coverMaxExtraHeight
                
                if newValue.y <= conditionValue {
                    throttledContentOffset = newValue
                } else {
                    throttledContentOffset.y = conditionValue
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
        -contentOffset.y <= coverMaxExtraHeight ? 1 : 0
    }
    
    // MARK: - setCoverOffsetY
    func setCoverTextOffsetY(_ value: CGFloat) {
        let triggerLine: CGFloat = coverPhotoFrameStaticMaxY + coverMaxExtraHeight
        coverTextOffsetY = value - triggerLine
    }
}
