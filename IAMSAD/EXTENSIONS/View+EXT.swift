//
//  View+EXT.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-09.
//

import SwiftUI

@MainActor
extension View {
    // MARK: - previewViewModifier
    var previewViewModifier: some View {
        self
            .dynamicTypeSize(...DynamicTypeSize.xLarge)
            .environmentObject(Avatar.shared)
            .environmentObject(AvatarSheetVM.shared)
            .environmentObject(ProfileVM.shared)
            .environmentObject(ConversationsVM.shared)
            .tint(.accent)
    }
    
    // MARK: - standardAccentColorBottomButtonViewModifier
    func standardAccentColorBottomButtonViewModifier(showProgressIndicator: Bool = false) -> some View {
        self
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .background(.accent)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(alignment: .trailing) {
                ProgressView()
                    .tint(Color(uiColor: .tertiarySystemBackground))
                    .opacity(showProgressIndicator ? 1 : 0)
                    .padding(.trailing)
            }
            .padding(.horizontal, 30)
    }
    
    // MARK: - standardNonPrimaryGrayWhiteBottomButtonViewModifier
    var standardNonPrimaryGrayWhiteBottomButtonViewModifier: some View {
        self
            .font(.headline)
            .foregroundStyle(.white)
            .padding(.vertical)
            .padding(.horizontal, screenWidth * 0.14)
            .background(Color(uiColor: .systemGray5))
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
    
    // MARK: - topPartBackgroundEffectOnScrollViewModifier
    func topPartBackgroundEffectOnScrollViewModifier(
        minY: CGFloat,
        maxY: Binding<CGFloat>,
        showBackgroundEffect: Binding<Bool>
    ) -> some View {
        self
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(
                            key: CustomCGFloatPreferenceKey.self,
                            value: proxy.frame(in: .global).maxY
                        )
                        .onPreferenceChange(CustomCGFloatPreferenceKey.self) {
                            maxY.wrappedValue = $0
                            showBackgroundEffect.wrappedValue = $0 > minY
                        }
                }
            )
    }
    
    // MARK: - bottomPartBackgroundEffectOnScrollViewModifier
    func bottomPartBackgroundEffectOnScrollViewModifier(minY: Binding<CGFloat>) -> some View {
        self
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(
                            key: CustomCGFloatPreferenceKey.self,
                            value: proxy.frame(in: .global).minY
                        )
                        .onPreferenceChange(CustomCGFloatPreferenceKey.self) { minY.wrappedValue = $0.rounded() }
                }
            )
    }
    
    // MARK: - geometryReaderDimensionViewModifier
    func geometryReaderDimensionViewModifier(_ binding: Binding<CGFloat>, dimension: DimensionTypes, extraValue: CGFloat = 0) -> some View {
        self
            .background(
                GeometryReader { geo in
                    Color.clear
                        .preference(
                            key: CustomCGFloatPreferenceKey.self,
                            value: dimension == .width ? geo.size.width : geo.size.height
                        )
                        .onPreferenceChange(CustomCGFloatPreferenceKey.self) {
                            binding.wrappedValue = $0 + extraValue
                        }
                }
            )
    }
    
    // MARK: - geometryReaderSizeViewModifier
    func geometryReaderSizeViewModifier(_ binding: Binding<CGSize>, extraWidth: CGFloat = 0, extraHeight: CGFloat = 0) -> some View {
        self
            .background(
                GeometryReader { geo in
                    Color.clear
                        .preference(key: CustomCGSizePreferenceKey.self, value: geo.size)
                        .onPreferenceChange(CustomCGSizePreferenceKey.self) {
                            binding.wrappedValue = .init(
                                width: $0.width + extraWidth,
                                height: $0.height + extraHeight
                            )
                        }
                }
            )
    }
    
    // MARK: - geometryReaderFrameViewModifier
    @ViewBuilder
    func geometryReaderFrameViewModifier(
        coordinateSpace: CoordinateSpace = .global,
        rect: RectCoordinateTypes,
        _ binding: Binding<CGFloat>
    ) -> some View {
        self
            .background {
                GeometryReader { geo in
                    Group {
                        switch rect {
                        case .minX:
                            Color.clear.preference(
                                key: CustomCGFloatPreferenceKey.self,
                                value: geo.frame(in: .global).minX
                            )
                        case .midX:
                            Color.clear.preference(
                                key: CustomCGFloatPreferenceKey.self,
                                value: geo.frame(in: .global).midX
                            )
                        case .maxX:
                            Color.clear.preference(
                                key: CustomCGFloatPreferenceKey.self,
                                value: geo.frame(in: .global).maxX
                            )
                        case .minY:
                            Color.clear.preference(
                                key: CustomCGFloatPreferenceKey.self,
                                value: geo.frame(in: .global).minY
                            )
                        case .midY:
                            Color.clear.preference(
                                key: CustomCGFloatPreferenceKey.self,
                                value: geo.frame(in: .global).midY
                            )
                        case .maxY:
                            Color.clear.preference(
                                key: CustomCGFloatPreferenceKey.self,
                                value: geo.frame(in: .global).maxY
                            )
                        }
                    }
                    .onPreferenceChange(CustomCGFloatPreferenceKey.self) {
                        binding.wrappedValue = $0
                    }
                }
            }
    }
    
    // MARK: - sheetTopTrailingCloseButtonViewModifier
    func sheetTopTrailingCloseButtonViewModifier(
        isVisible: Bool = true,
        size: CGFloat = 35,
        _ action: @escaping () -> Void
    ) -> some View {
        self
            .overlay(alignment: .topTrailing) {
                if isVisible {
                    Button {
                        action()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.secondary, Color(uiColor: .systemGray5))
                            .frame(width: size, height: size)
                    }
                    .buttonStyle(.plain)
                    .padding()
                }
            }
    }
    
    // MARK: - presentationBackgroundViewModifier
    @ViewBuilder
    func presentationBackgroundViewModifier(_ material: Material = .ultraThinMaterial) -> some View {
        if #available(iOS 16.4, *) {
            self
                .presentationBackground(material)
        } else { self }
    }
    
    // MARK: - registerProfileTapEvent
    func registerProfileTapEventViewModifier(event: Profile_TapEventTypes, action: @escaping () -> Void) -> some View {
        self
            .background {
                GeometryReader { geo in
                    Color.clear
                        .preference(
                            key: CustomCGRectPreferenceKey.self,
                            value: geo.frame(in: .global)
                        )
                        .onPreferenceChange(CustomCGRectPreferenceKey.self) {
                            ProfileVM.shared.registerEventCoordinates(event: event, frame: $0) {
                                action()
                            }
                        }
                }
            }
    }
    
    // MARK: - profileTabContentsIntrospect
    func profileTabContentsIntrospect(vm profileVM: ProfileVM, tab: Profile_TabLabelTypes) -> some View {
        self
            .introspect(.scrollView, on: .iOS(.v17)) { scrollView in
                // Handles scroll view's vertical content offset
                let condition1: Bool = profileVM.selectedTabType != tab
                let condition2: Bool = scrollView.contentOffset.y <= profileVM.contentOffsetMaxY
                let condition3: Bool = profileVM.contentOffsetY < profileVM.contentOffsetMaxY
                let condition4: Bool = condition2 || condition3
                
                if profileVM.currentGestureType == .drag {
                    if condition1, condition4 {
                        scrollView.contentOffset.y = profileVM.contentOffsetY
                    }
                } else if condition4 {
                    scrollView.contentOffset.y = profileVM.contentOffsetY
                }
                
                // Scrolls to tab labels anchoring point at top
                if let OffsetY: CGFloat = profileVM.scrollToTopContentOffsetY {
                    if scrollView.contentOffset.y < profileVM.contentOffsetMaxY,
                       !scrollView.isTracking {
                        scrollView.setContentOffset(.init(x: 0, y: OffsetY), animated: true)
                    }
                    
                    profileVM.scrollToTopContentOffsetY = nil
                }
                
                // Handles vertical scroll indicator insets
                scrollView.verticalScrollIndicatorInsets.top = profileVM.profileContentHeight +
                profileVM.horizontalTabHeight +
                (scrollView.contentOffset.y < 0 ? abs(scrollView.contentOffset.y) : 0)
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        print(value)
                        ///  to avoid unnecessary pull to refreshes, we can take the advantage of this closures execution.
                        ///  because, this closure get executed only on time when the user start dragging, and that's when the first drag event happens.
                        ///  so then we can check when whether the content offset of the content is within a certain threshold or not and disable pull to refresh progress view.
                    }
            )
    }
    
    // MARK: - presentStatusCircleHandler
    @ViewBuilder
    func presentStatusCircleHandlerViewModifier(isPrimary: Bool, isOnline: Bool) -> some View {
        let vm: ProfileVM = .shared
        let ratio: CGFloat = vm.profilePhotoOffsetRatio
        var lineWidth: CGFloat {
            let eyeSmoothingValue: CGFloat = 1
            let value:  CGFloat = vm.secondaryProfilePhotoBorderSize - eyeSmoothingValue
            return isPrimary ? value*ratio : value
        }
        var frame: CGFloat {
            let value:  CGFloat = vm.secondaryPresenceStatusCircleFrameSize
            return isPrimary ? value*ratio : value
        }
        var offset: CGFloat {
            let value:  CGFloat = -vm.secondaryPresenceStatusCircleFrameSize / 2
            return isPrimary ? value*ratio : value
        }
        
        self
            .overlay(alignment: .bottomTrailing) {
                if isOnline {
                    Circle()
                        .stroke(.colorScheme, lineWidth: lineWidth)
                        .fill(.presentStatus)
                        .frame(width: frame, height: frame)
                        .offset(x: offset, y: offset)
                }
            }
    }
    
    // MARK: - sheetListButtonStyleViewModifier
    var sheetListButtonStyleViewModifier: some View {
        self.buttonStyle(SheetListButtonStyle())
    }
    
    // MARK: - conversationsBubbleShadowViewModifier
    func conversationsBubbleShadowViewModifier(
        _ colorScheme: ColorScheme,
        @ViewBuilder bubble: () -> AnyShape
    ) -> some View {
        self
            .background {
                if colorScheme == .light {
                    bubble()
                        .fill(.black.opacity(0.1))
                        .offset(y: 1)
                }
            }
    }
    
    // MARK: - messageBubbleContentDefaultPadding
    @ViewBuilder
    var messageBubbleContentDefaultPadding: some View {
        let values = MessageBubbleValues.self
        
        self
            .padding(.vertical, values.innerVPadding)
            .padding(.horizontal, values.innerHPadding)
    }
}

// MARK: - OTHER
// MARK: - CustomCGFloatPreferenceKey
struct CustomCGFloatPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: - CustomCGPointPreferenceKey
struct CustomCGPointPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}

// MARK: - CustomCGSizePreferenceKey
struct CustomCGSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

// MARK: - CustomCGRectPreferenceKey
struct CustomCGRectPreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

// MARK: - SheetListButtonStyle
struct SheetListButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) private var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed
                        ? Color(uiColor: .systemGray2)
                        : colorScheme == .dark ? Color(uiColor: .systemGray5) : .white
            )
    }
}
