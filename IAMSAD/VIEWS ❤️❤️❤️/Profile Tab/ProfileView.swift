//
//  ProfileView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-09.
//

import SwiftUI
import BBSwiftUIKit
import Combine

// this is what i wanted.

struct ProfileView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    @State private var arrowDownAngle: CGFloat = .zero
    @State private var arrowDownOpacity: CGFloat = .zero
    @State private var progressIndicatorOpacity: CGFloat = .zero
    @State private var tabSelection: Int = 1
    @State var contentOffset: CGPoint = .zero
    @State var topToolbarStaticMidY: CGFloat = .zero
    @State var topToolbarStaticMaxY: CGFloat = .zero
    @State var topToolbarLeadingItemStaticMaxX: CGFloat = .zero
    let topToolbarIconsFrameSize: CGFloat = 14
    let maxArrowOpacityCoverHeight: CGFloat = 10
    @State var profileInfoTopContentDynamicMinY: CGFloat = .zero
    let secondaryProfilePhotoFrameSize: CGFloat = 75
    var secondaryProfilePhotoSize: CGFloat { secondaryProfilePhotoFrameSize - 7 }
    let profilePhotoOffsetFraction: CGFloat = 1 - 1/3
    @State var coverTextOffsetY: CGFloat = .zero
    @State var tapRegisteredEventsArray: [TapRegisterModel<ProfileTabEventTypes>] = []
    @State var tapCoordinates: CGPoint = .zero
    
    @State var profileTab: ProfileTab = .shared
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                fullSizeContent
                profileInfoContent
                
                Testing123(
                    contentOffset: setter($contentOffset),
                    tapCoordinates: $tapCoordinates,
                    topContentHeight: profileTab.profileContentHeight
                )
                
                coverContent
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
            .onChange(of: tapCoordinates) { executeTapEvent($0) }
        }
    }
}

extension ProfileView {
    func setter(_ value: Binding<CGPoint>) -> Binding<CGPoint> {
        Binding {
            value.wrappedValue
        } set: {
            value.wrappedValue = $0
            profileTab.contentOffset = $0
        }
    }
}

// MARK: - PREVIEWS
#Preview("ProfileView") { ProfileView().previewViewModifier }

enum ProfilePhotoTypes { case onCover, inScrollView }

// MARK: - EXTENSIONS
@MainActor
extension ProfileView {
    // MARK: - fullSizeContent
    private var fullSizeContent: some View {
        Color.tabBarNSystemBackground
            .ignoresSafeArea()
    }
    
    // MARK: - profileInfoContent
    private var profileInfoContent: some View {
        BBScrollView(.vertical, contentOffset: setter($contentOffset)) {
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Color.clear
                        .frame(height: profileTab.coverPhotoFrameStaticMaxY)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        profileInfoTopContent
                        nameNGenderTexts
                    }
                    
                    joinedDateNBioTexts
                }
                .geometryReaderDimensionViewModifier($profileTab.profileContentHeight, dimension: .height)
                
                Color.clear
                    .frame(height: screenHeight*3)
                    .allowsHitTesting(false)
                    .disabled(true)
            }
            .padding(.horizontal)
            .frame(width: screenWidth)
        }
        .bb_showsVerticalScrollIndicator(false)
        .ignoresSafeArea(edges: .top)
    }
    
    // MARK: - coverContent
    private var coverContent: some View {
        ProfileCoverContentView(
            profileName: "Kavinda Dilshan",
            subHeadlineText: "trusted by 21 people",
            topToolbarLeadingItemStaticMaxX: topToolbarLeadingItemStaticMaxX,
            topToolbarStaticMidY: topToolbarStaticMidY,
            coverTextOffsetY: coverTextOffsetY,
            iconFrameSize: topToolbarIconsFrameSize,
            coverPhotoURL: URL(string: "https://cdn.pixabay.com/photo/2012/08/27/14/19/mountains-55067_1280.png"),
            coverType: .photo,
            coverMaxExtraHeight: profileTab.coverMaxExtraHeight,
            coverExtraHeight: -profileTab.throttledContentOffset.y,
            arrowIconAngle: 0, // add a property <------
            arrowIconOpacity: 1, // add a property <-----
            progressIndicatorOpacity: 1, // add a property <------
            profilePhotoFrameSize: secondaryProfilePhotoFrameSize,
            profilePhotoSize: secondaryProfilePhotoSize,
            profilePhotoOffsetFraction: profilePhotoOffsetFraction
        )
        .ignoresSafeArea(edges: .top)
        .allowsHitTesting(false)
    }
    
    // MARK: - profileInfoTopContent
    private var profileInfoTopContent: some View {
        HStack {
            primaryProfilePhoto
            
            Spacer()
            
            HStack(spacing: 15) {
                Text("Edit Profile")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(Color.primary)
                    .frame(width: 130, height: 32)
                    .background(.clear)
                    .clipShape(.rect(cornerRadius: 9))
                    .background(
                        RoundedRectangle(cornerRadius: 9)
                            .stroke(Color(uiColor: .systemGray4), lineWidth: 1)
                    )
                    .background {
                        GeometryReader { geo in
                            Color.clear
                                .preference(
                                    key: CustomCGRectPreferenceKey.self,
                                    value: geo.frame(in: .global)
                                )
                                .onPreferenceChange(CustomCGRectPreferenceKey.self) {
                                    registerEventCoordinates(event: .general, frame: $0) {
                                        // follow/unfollow/edit profile action goes here...
                                        print("general - follow/unfollow/edit profile action got triggered...")
                                    }
                                }
                        }
                    }
                
                Circle()
                    .stroke(Color(uiColor: .systemGray4), lineWidth: 1)
                    .frame(width: 32, height: 32)
                    .overlay {
                        Image(.share)
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .padding(10)
                    }
                    .tint(.primary)
                    .background {
                        GeometryReader { geo in
                            Color.clear
                                .preference(
                                    key: CustomCGRectPreferenceKey.self,
                                    value: geo.frame(in: .global)
                                )
                                .onPreferenceChange(CustomCGRectPreferenceKey.self) {
                                    registerEventCoordinates(event: .share, frame: $0) {
                                        // share action goes here...
                                        print("share action got triggered...")
                                    }
                                }
                        }
                    }
            }
        }
    }
    
    // MARK: - primaryProfilePhoto
    private var primaryProfilePhoto: some View {
        let primaryProfilePhotoFrameSize: CGFloat = secondaryProfilePhotoFrameSize * profilePhotoOffsetFraction
        let primaryProfilePhotoSize: CGFloat = secondaryProfilePhotoSize * profilePhotoOffsetFraction
        
        return Circle()
            .fill(.tabBarNSystemBackground)
            .frame(
                width: primaryProfilePhotoFrameSize,
                height: primaryProfilePhotoFrameSize
            )
            .overlay {
                Image(.profilePhoto)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(
                        width: primaryProfilePhotoSize,
                        height: primaryProfilePhotoSize
                    )
            }
            .opacity(getProfilePhotoOpacity())
    }
    
    // MARK: - nameNGenderTexts
    private var nameNGenderTexts: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Kavinda Dilshan")
                    .font(.system(size: 24, weight: .bold))
                
                Image(systemName: "checkmark.seal.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 17)
                    .fontWeight(.semibold)
                    .foregroundStyle(.cyan)
            }
            .background {
                GeometryReader { geo in
                    Color.clear
                        .preference(key: CustomCGFloatPreferenceKey.self, value: geo.frame(in: .global).minY)
                        .onPreferenceChange(CustomCGFloatPreferenceKey.self) { value in
                            let triggerLine: CGFloat = profileTab.coverPhotoFrameStaticMaxY + profileTab.coverMaxExtraHeight
                            coverTextOffsetY = value - triggerLine
                        }
                }
            }
            
            Text("Male")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
    
    // MARK: - joinedDateNBioTexts
    private var joinedDateNBioTexts: some View {
        VStack(alignment: .leading, spacing: 20) {
            Group {
                Label("Joined December 2023", systemImage: "calendar")
                
                HStack(alignment: .bottom) {
                    Text("Sajee's Hubby 👩🏻‍❤️‍👨🏻\n1st Class Honours Graduate 👨🏻‍🎓\nUI/UX Designer/Engineer 👨🏻‍💻\nFront-End SwiftUI iOS Develoer 👨🏻‍💻")
                        .lineSpacing(5)
                    
                    Text("more")
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                        .padding(.leading, 6)
                        .background {
                            GeometryReader { geo in
                                Color.clear
                                    .preference(
                                        key: CustomCGRectPreferenceKey.self,
                                        value: geo.frame(in: .global)
                                    )
                                    .onPreferenceChange(CustomCGRectPreferenceKey.self) {
                                        registerEventCoordinates(event: .more, frame: $0) {
                                            // more action goes here...
                                            print("more action got triggered...")
                                        }
                                    }
                            }
                        }
                }
                
                HStack(spacing: 5) {
                    HStack(spacing: 5) {
                        HStack(spacing: -8) {
                            Circle()
                                .fill(.tabBarNSystemBackground)
                                .frame(width: 20, height: 20)
                                .overlay {
                                    Image(.follower1)
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                        .padding(1.5)
                                }
                            
                            Circle()
                                .fill(.tabBarNSystemBackground)
                                .frame(width: 20, height: 20)
                                .overlay {
                                    Image(.follower2)
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                        .padding(1.5)
                                }
                            
                            Circle()
                                .fill(.tabBarNSystemBackground)
                                .frame(width: 20, height: 20)
                                .overlay {
                                    Image(.follower3)
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                        .padding(1.5)
                                }
                        }
                        .padding(.trailing, 2)
                        
                        Text("69 followers")
                    }
                    .background {
                        GeometryReader { geo in
                            Color.clear
                                .preference(
                                    key: CustomCGRectPreferenceKey.self,
                                    value: geo.frame(in: .global)
                                )
                                .onPreferenceChange(CustomCGRectPreferenceKey.self) {
                                    registerEventCoordinates(event: .followers, frame: $0) {
                                        // followers action goes here...
                                        print("followers action got triggered...")
                                    }
                                }
                        }
                    }
                    
                    Circle()
                        .fill(.secondary)
                        .frame(width: 2, height: 2)
                        .offset(y: 2)
                    
                    Text("kd_techniques/sleepi.com")
                        .tint(.secondary)
                        .background {
                            GeometryReader { geo in
                                Color.clear
                                    .preference(
                                        key: CustomCGRectPreferenceKey.self,
                                        value: geo.frame(in: .global)
                                    )
                                    .onPreferenceChange(CustomCGRectPreferenceKey.self) {
                                        registerEventCoordinates(event: .link, frame: $0) {
                                            // link action goes here...
                                            print("link action got triggered...")
                                        }
                                    }
                            }
                        }
                }
                .foregroundStyle(.secondary)
            }
            .font(.subheadline)
        }
        .padding(.top)
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - getProfilePhotoOpacity
    private func getProfilePhotoOpacity() -> CGFloat {
        -contentOffset.y <= profileTab.coverMaxExtraHeight ? 1 : 0
    }
    
    // MARK: - registerEventCoordinates
    private func registerEventCoordinates(
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
    private func executeTapEvent(_ coordinates: CGPoint) {
        let x: CGFloat = coordinates.x
        let y: CGFloat = coordinates.y
        
        guard let item: TapRegisterModel = tapRegisteredEventsArray.first(where: {
            ($0.frame.minX <= x && $0.frame.maxX >= x) && ($0.frame.minY <= y && $0.frame.maxY >= y)
        }) else { return }
        
        item.action()
    }
}

class ProfileTab: ObservableObject {
    let coverPhotoFrameStaticMaxY: CGFloat = 140
    let coverMaxExtraHeight: CGFloat = -43
    
    @Published var contentOffset: CGPoint = .zero
    @Published var throttledContentOffset: CGPoint = .zero
    @Published var profileContentHeight: CGFloat = .zero
    
    var cancellable: Set<AnyCancellable> = []
    
    static let shared: ProfileTab = .init()
    
    init() {
        contentOffsetSubscriber()
    }
    
    func contentOffsetSubscriber() {
        $contentOffset
            .subscribe(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                guard let self = self else { return }
                
                let conditionValue: CGFloat = profileContentHeight-coverPhotoFrameStaticMaxY-coverMaxExtraHeight
                
                if newValue.y <= conditionValue {
                    throttledContentOffset = newValue
                } else {
                    throttledContentOffset.y = conditionValue
                }
            }
            .store(in: &cancellable)
    }
}

enum ProfileTabEventTypes {
    case general, share, more, followers, link
}
