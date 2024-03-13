//
//  ProfileViewModel.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-03.
//

import SwiftUI
import Combine

@MainActor
final class ProfileViewModel: ObservableObject {
    // MARK: - PRORPERTIES
    @Published var array: [MockModel] = []
    // MARK: - Common
    @Published var isScrolling: Bool = false
    @Published var tapCoordinatesArray: [TapCoordinatesModel] = []
    @Published var tapCoordinates: CGPoint = .zero
    @Published var contentOffset: CGPoint = .zero
    @Published var contentOffsetYArray: [Profile_TabContentOffsetModel] = []
    @Published var selectedTabType: Profile_TabLabelTypes = .posts
    @Published var profileContentHeight: CGFloat = .zero
    @Published var horizontalTabHeight: CGFloat = .zero
    let horizontalTabsExtraTopPadding: CGFloat = 10
    var cancellable: Set<AnyCancellable> = []
    
    // MARK: - Toolbar
    @Published var topToolbarStaticMidY: CGFloat = .zero
    @Published var topToolbarStaticMaxY: CGFloat = .zero
    @Published var topToolbarLeadingItemStaticMaxX: CGFloat = .zero
    let topToolbarIconsFrameSize: CGFloat = 14
    
    // MARK: - Icons
    let iconExtraFrameHeight: CGFloat = 2
    var extendedIconFrameSize: CGFloat {
        topToolbarIconsFrameSize + iconExtraFrameHeight
    }
    
    // MARK: - Cover
    let coverColor: Color = .accent
    let coverStaticHeight: CGFloat = 140
    let maxCoverBlur: CGFloat = 8
    let safeBlurFrameSize: CGFloat = 20 /// to avoid image corners getting ugly when blurring
    let coverMaxExtraHeight: CGFloat = -43
    @Published var coverType: Profile_CoverTypes = .photo
    @Published var coverPhotoURL: URL? = .init(string: "https://www.tomerazabi.com/wp-content/uploads/2020/12/IMG_7677-7751-1000px-SJPEG-V3.jpg")
    @Published var coverExtraHeight: CGFloat = .zero
    
    // MARK: - Cover Texts
    @Published var coverTextStaticHeight: CGFloat = .zero
    var coverTextMaxOffsetY: CGFloat {
        -(
            coverStaticHeight +
            coverMaxExtraHeight -
            topToolbarStaticMidY +
            coverTextStaticHeight/2
        )
    }
    @Published var coverTextOffsetY: CGFloat = .zero
    @Published var subHeadlineText: String = "trusted by 123 people"
    
    // MARK: - Refreshable
    @Published var arrowIconAngle: CGFloat = .zero
    @Published var arrowIconOpacity: CGFloat = .zero
    @Published var progressIndicatorOpacity: CGFloat = .zero
    
    // MARK: - Profile Photo
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
    @Published var profilePhotoURL: URL? = .init(string: "https://img.freepik.com/free-photo/portrait-young-woman-with-natural-make-up_23-2149084907.jpg")
    
    // MARK: - Profile Info
    @Published var name: String = "Deepashika Sajeewanie"
    @Published var badgeType: VerifiedBadgeTypes? = .blue
    @Published var gender: GenderTypes = .female
    @Published var joinedDate: String = "June 2023"
    
    // MARK: - Buttons + Link
    @Published var buttonType: Profile_GeneralButtonTypes = .following
    @Published var _3FollowersArray: [String] = [
        "https://picsum.photos/50/50",
        "https://picsum.photos/51/51",
        "https://picsum.photos/52/52"
    ]
    @Published var followersCount: Int = 1200
    @Published var linkText: String? = "kd_techniques/sleepi.com"
    @Published var linkURL: String? = "https://exmaple.com/"
    
    // MARK: - Bio
    @Published var bioText: String = "Sajee's Hubby 👩🏻‍❤️‍👨🏻\n1st Class Honours Graduate 👨🏻‍🎓\nUI/UX Designer/Engineer 👨🏻‍💻\nFront-End SwiftUI iOS Develoer 👨🏻‍💻"
    
    // MARK: Singleton
    static let shared: ProfileViewModel = .init()
    
    // MARK: - INITIALAIER
    init() {
        tapCoordinatesSubscriber()
        contentOffsetSubscriber()
        contentOffsetDebouncedSubscriber()
        initializeTabLabelContentOffsetsArray()
        
        for _ in 0...100 {
            self.array.append(.init(text: UUID().uuidString))
        }
        
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - Common
    
    // MARK: - initializeTabLabelContentOffsetsArray
    private func initializeTabLabelContentOffsetsArray() {
        if contentOffsetYArray.isEmpty {
            Profile_TabLabelTypes.allCases.forEach {
                contentOffsetYArray.append(.init(tab: $0))
            }
        }
    }
    
    // MARK: - setTabLabelContentOffsetY
    private func setTabLabelContentOffsetY(_ offsetY: CGFloat) {
        for index in contentOffsetYArray.indices {
            contentOffsetYArray[index].setOffsetY(offsetY)
        }
    }
    
    // MARK: contentOffsetSubscriber
    private func contentOffsetSubscriber() {
        $contentOffset
            .sink { [weak self] newValue in
                guard let self = self else { return }
                
                isScrolling = true
                
                let conditionValue1: CGFloat = profileContentHeight -
                coverStaticHeight - coverMaxExtraHeight
                
                let conditionValue2: CGFloat = profileContentHeight -
                coverStaticHeight - coverMaxExtraHeight
                
                coverExtraHeight = newValue.y <= conditionValue1
                ?  -newValue.y
                : -conditionValue1
                
                if newValue.y <= conditionValue2 {
                    setTabLabelContentOffsetY(newValue.y)
                }
            }
            .store(in: &cancellable)
    }
    
    // MARK: contentOffsetDebouncedSubscriber
    private func contentOffsetDebouncedSubscriber() {
        $contentOffset
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] newValue in
                guard let self = self else { return }
                isScrolling = false
            }
            .store(in: &cancellable)
    }
    
    // MARK: registerEventCoordinates
    func registerEventCoordinates(
        event: Profile_TapEventTypes,
        frame: CGRect,
        action: @escaping ()->()
    ) {
        guard let index: Int = tapCoordinatesArray.firstIndex(where: { $0.event == event}) else {
            tapCoordinatesArray.append(.init(
                frame: frame,
                event: event,
                action: action
            ))
            
            return
        }
        
        tapCoordinatesArray[index].setFrame(frame)
    }
    
    // MARK: executeTapEvent
    private func executeTapEvent(_ coordinates: CGPoint) {
        let x: CGFloat = coordinates.x
        let y: CGFloat = coordinates.y
        
        guard let item: TapCoordinatesModel = tapCoordinatesArray.first(where: {
            ($0.frame.minX <= x && $0.frame.maxX >= x) && ($0.frame.minY <= y && $0.frame.maxY >= y)
        }) else { return }
        
        item.action()
    }
    
    // MARK: tapCoordinatesSubscriber
    private func tapCoordinatesSubscriber() {
        $tapCoordinates
            .sink { [weak self] newValue in
                guard let self = self else { return }
                executeTapEvent(newValue)
            }
            .store(in: &cancellable)
    }
    
    // MARK: setProfileContentHeight
    func setProfileContentHeight(_ value: CGFloat) {
        profileContentHeight = value + horizontalTabsExtraTopPadding
    }
    
    // MARK: - Profile Cover
    
    // MARK: getCoverHeight
    func getCoverHeight() -> CGFloat {
        /// this limits the cover height when it reaches its controlled minimum value.
        coverStaticHeight +
        (
            coverExtraHeight > coverMaxExtraHeight
            ? coverExtraHeight
            : coverMaxExtraHeight
        )
    }
    
    // MARK: getCoverBlurOnScrollDown
    func getCoverBlurOnScrollDown() -> CGFloat {
        let maxBlurHeight: CGFloat = 30
        
        if coverExtraHeight > 0 {
            return coverExtraHeight > maxBlurHeight
            ? maxCoverBlur
            : coverExtraHeight/maxBlurHeight*maxCoverBlur
        }
        
        return .zero
    }
    
    // MARK: getCoverBlurOnScrollUp
    func getCoverBlurOnScrollUp() -> CGFloat {
        if coverTextOffsetY < 0 {
            return coverTextOffsetY > coverTextMaxOffsetY
            ? coverTextOffsetY / coverTextMaxOffsetY * maxCoverBlur
            : maxCoverBlur
        }
        
        return 0
    }
    
    // MARK: setCoverOffsetY
    func setCoverTextOffsetY(_ value: CGFloat) {
        let triggerLine: CGFloat = coverStaticHeight + coverMaxExtraHeight
        coverTextOffsetY = value < triggerLine ? value - triggerLine : 0
    }
    
    // MARK: getProfilePhotoScale
    func getProfilePhotoScale() -> CGFloat {
        let calculation1: CGFloat = 1 - profilePhotoOffsetFraction
        let calculation2: CGFloat = coverExtraHeight / coverMaxExtraHeight * calculation1
        let calculation3: CGFloat = 1 - (calculation2 >= .zero ? calculation2 : .zero)
        
        return calculation3 > .zero ? calculation3 : .zero
    }
    
    // MARK: getCoverProfilePhotoOpacity
    func getCoverProfilePhotoOpacity() -> CGFloat {
        coverExtraHeight <= coverMaxExtraHeight ? 0 : 1
    }
    
    // MARK: getCoverTextOffset
    func getCoverTextOffset() -> CGFloat {
        coverTextOffsetY > coverTextMaxOffsetY
        ? (coverTextOffsetY < 0) ? coverTextOffsetY : .zero
        : coverTextMaxOffsetY
    }
    
    // MARK: getCoverTextOpacity
    func getCoverTextOpacity() -> CGFloat {
        let preSmoothingValue: CGFloat = 10 /// this will give little bit more prior opacity before offset hits max offset Y.
        return 1 / (coverTextMaxOffsetY + preSmoothingValue) * coverTextOffsetY
    }
    
    // MARK: - Profile Photo
    
    // MARK: getProfilePhotoOpacity
    func getProfilePhotoOpacity() -> CGFloat {
        -contentOffset.y <= coverMaxExtraHeight ? 1 : 0
    }
    
    // MARK: - Profile Bio
    
    // MARK: getPlural
    func getPlural() -> String {
        followersCount == 0 || followersCount > 1 ? "s" : ""
    }
}
