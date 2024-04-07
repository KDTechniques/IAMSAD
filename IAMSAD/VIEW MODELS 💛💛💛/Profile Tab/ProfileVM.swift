//
//  ProfileVM.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-03.
//

import SwiftUI
import Combine

enum RefreshableStateTypes {
    case pending, none
}

@MainActor
final class ProfileVM: ObservableObject {
    // MARK: - PRORPERTIES
    @Published var array: [MockModel] = []
    // MARK: - Common
    @Published var selectedAccount: AccountTypes = .personal
    @Published var isSafeSubscribing: Bool = false
    @Published var isScrolling: Bool = false
    @Published var tapCoordinatesArray: [TapCoordinatesModel] = []
    @Published var tapCoordinates: CGPoint = .zero
    @Published var contentOffsetY: CGFloat = 0
    @Published var scrollToTopContentOffsetY: CGFloat? = nil
    @Published var contentOffsetYArray: [Profile_TabContentOffsetModel] = []
    @Published var selectedTabType: Profile_TabLabelTypes = .posts
    @Published var currentGestureType: CustomStripTabGestureTypes = .drag
    @Published var profileContentHeight: CGFloat = 0
    @Published var horizontalTabHeight: CGFloat = 0
    let horizontalTabsExtraTopPadding: CGFloat = 10
    var contentOffsetMaxY: CGFloat {
        profileContentHeight - coverStaticHeight -
        coverMaxExtraHeight
    }
    var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Toolbar
    @Published var topToolbarStaticMidY: CGFloat = 0
    @Published var topToolbarStaticMaxY: CGFloat = 0
    @Published var topToolbarLeadingItemStaticMaxX: CGFloat = 0
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
    @Published var coverExtraHeight: CGFloat = 0
    
    // MARK: - Refreshable
    @Published var arrowIconAngle: CGFloat = 0
    @Published var arrowIconOpacity: CGFloat = 0
    @Published var progressIndicatorOpacity: CGFloat = 0
    @Published var refreshableState: RefreshableStateTypes = .none
    let maxArrowOpacityCoverHeight: CGFloat = 15
    let refreshableTriggerPoint: CGFloat = 30
    
    // MARK: - Cover Texts
    @Published var coverTextStaticHeight: CGFloat = 0
    var coverTextMaxOffsetY: CGFloat {
        -(
            coverStaticHeight +
            coverMaxExtraHeight -
            topToolbarStaticMidY +
            coverTextStaticHeight/2
        )
    }
    @Published var coverTextOffsetY: CGFloat = 0
    @Published var subHeadlineText: String = "trusted by 123 people"
    
    // MARK: - Profile Photo
    let profilePhotoOffsetRatio: CGFloat = 1 - 1/3
    let presenceStatusCircleRatio: CGFloat = 8.6
    // Secondary
    let secondaryProfilePhotoFrameSize: CGFloat = 75
    let secondaryProfilePhotoBorderSize: CGFloat = 7
    var secondaryProfilePhotoSize: CGFloat {
        secondaryProfilePhotoFrameSize - secondaryProfilePhotoBorderSize
    }
    var secondaryPresenceStatusCircleFrameSize: CGFloat {
        secondaryProfilePhotoFrameSize / presenceStatusCircleRatio
    }
    
    // Primary
    var primaryProfilePhotoFrameSize: CGFloat {
        secondaryProfilePhotoFrameSize * profilePhotoOffsetRatio
    }
    var primaryProfilePhotoSize: CGFloat {
        secondaryProfilePhotoSize * profilePhotoOffsetRatio
    }
    @Published var profilePhotoURL: URL? = .init(string: "https://img.freepik.com/free-photo/portrait-young-woman-with-natural-make-up_23-2149084907.jpg")
    @Published var avatarImageName: URL? = Bundle.main.url(forResource: "Super Heroes_29", withExtension: "png")
    
    // MARK: - Profile Info
    @Published var personalName: String = "Deepashika Sajeewanie"
    @Published var anonymousName: String = "Beauty_Queen96💃💋"
    @Published var badgeType: VerifiedBadgeTypes? = .blue
    @Published var gender: GenderTypes = .female
    @Published var joinedDate: String = "June 2023"
    
    // MARK: - Buttons + Link
    @Published var buttonType: Profile_GeneralButtonTypes = .following
    @Published var _3FollowersArray: [String] = [
        "https://picsum.photos/50",
        "https://picsum.photos/51",
        "https://picsum.photos/52"
    ]
    @Published var followersCount: Int = 1200
    @Published var linkText: String? = "kd_techniques/sleepi.com"
    @Published var linkURL: String? = "https://exmaple.com/"
    @Published var isPresentedFollowersSheet: Bool = false
    
    // MARK: - Bio
    @Published var bioText: String = "Sajee's Hubby 👩🏻‍❤️‍👨🏻\n1st Class Honours Graduate 👨🏻‍🎓\nUI/UX Designer/Engineer 👨🏻‍💻\nFront-End SwiftUI iOS Developer 👨🏻‍💻\n🇱🇰 🇨🇦 Toronto, ON"
    
    // MARK: Singleton
    static let shared: ProfileVM = .init()
    
    // MARK: - INITIALAIER
    init() {
        tapCoordinatesSubscriber()
        contentOffsetSubscriber()
        contentOffsetDebouncedSubscriber()
        initializeTabLabelContentOffsetsArray()
        refreshableStateSubscriber()
        
        for index in 0...100 {
            self.array.append(.init(text: index.description))
        }
    }
    
    // MARK: - FUNCTIONS
    
    private func mockNetworkCall() async -> Bool {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        return true
    }
    
    // MARK: - Common
    
    // MARK: handleSafeSubscribing
    func handleSafeSubscribing() {
        if !isSafeSubscribing {
            isSafeSubscribing = true
        }
    }
    
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
        if offsetY <= contentOffsetMaxY {
            for index in contentOffsetYArray.indices {
                contentOffsetYArray[index].setOffsetY(offsetY)
            }
        }
    }
    
    // MARK: contentOffsetSubscriber
    private func contentOffsetSubscriber() {
        $contentOffsetY
            .sink { [weak self] newValue in
                guard let self = self, isSafeSubscribing, !isPresentedFollowersSheet else { return }
                
                isScrolling = true
                setCoverHeight(newValue)
                setTabLabelContentOffsetY(newValue)
                handleRefreshable(newValue)
            }
            .store(in: &cancellables)
    }
    
    // MARK: contentOffsetDebouncedSubscriber
    private func contentOffsetDebouncedSubscriber() {
        $contentOffsetY
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] newValue in
                guard let self = self, isSafeSubscribing, !isPresentedFollowersSheet else { return }
                
                isScrolling = false
                networkRequestHandler(newValue)
            }
            .store(in: &cancellables)
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
                guard let self = self, isSafeSubscribing else { return }
                
                executeTapEvent(newValue)
            }
            .store(in: &cancellables)
    }
    
    // MARK: setProfileContentHeight
    func setProfileContentHeight(_ value: CGFloat) {
        profileContentHeight = value + horizontalTabsExtraTopPadding
    }
    
    // MARK: - Profile Cover
    
    // MARK: setCoverHeight
    private func setCoverHeight(_ offsetY: CGFloat) {
        coverExtraHeight = offsetY <= contentOffsetMaxY
        ?  -offsetY
        : -contentOffsetMaxY
    }
    
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
        let calculation1: CGFloat = 1 - profilePhotoOffsetRatio
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
        /// This will give little bit more prior opacity before offset hits max offset Y.
        let preSmoothingValue: CGFloat = 10
        return 1 / (coverTextMaxOffsetY + preSmoothingValue) * coverTextOffsetY
    }
    
    // MARK: - Refreshable
    
    // MARK: refreshableStateSubscriber
    private func refreshableStateSubscriber() {
        $refreshableState
            .sink { [weak self] newValue in
                guard let self = self, isSafeSubscribing else { return }
                
                if newValue == .none {
                    progressIndicatorOpacity = 0
                    arrowIconAngle = 0
                    scrollToTopContentOffsetY = contentOffsetMaxY
                } else {
                    HapticFeedbackGenerator().vibrate(type: .heavy)
                    /// The arrow icon takes 0.3 seconds to rotate 180 degrees on the view level animation.
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.3) { [weak self] in
                        self?.arrowIconOpacity = 0
                        self?.progressIndicatorOpacity =  1
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: handleRefreshable
    private func handleRefreshable(_ offsetY: CGFloat) {
        if offsetY <= 0, refreshableState == .none {
            let absValue: CGFloat = abs(offsetY)
            
            if absValue >= 0, absValue <= maxArrowOpacityCoverHeight {
                arrowIconAngle = 0
                arrowIconOpacity = absValue / maxArrowOpacityCoverHeight
            } else if absValue >= refreshableTriggerPoint {
                arrowIconAngle = 180
                refreshableState = .pending
            }
        } else if offsetY > 0 {
            progressIndicatorOpacity = 0
            arrowIconOpacity = 0
            arrowIconAngle = 0
        }
    }
    
    // MARK: networkRequestHandler
    private func networkRequestHandler(_ offsetY: CGFloat) {
        if refreshableState == .pending, offsetY >= 0 {
            Task { [weak self] in
                let _ = await self?.mockNetworkCall()
                self?.refreshableState = .none
            }
        }
    }
    
    // MARK: - Profile Photo
    
    // MARK: getProfilePhotoOpacity
    func getProfilePhotoOpacity() -> CGFloat {
        -contentOffsetY <= coverMaxExtraHeight ? 1 : 0
    }
    
    // MARK: - Profile Bio
    
    // MARK: getPlural
    func getPlural() -> String {
        followersCount == 0 || followersCount > 1 ? "s" : ""
    }
    
    // MARK: - Followers text
    
    // MARK: - handleFollowersSheetChanges
    func handleFollowersSheetChanges(_ isPresented: Bool) {
        isPresentedFollowersSheet = isPresented
    }
}
