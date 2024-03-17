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
    func geometryReaderDimensionViewModifier(_ binding: Binding<CGFloat>, dimension: DimensionTypes) -> some View {
        self
            .background(
                GeometryReader { geo in
                    Color.clear
                        .preference(
                            key: CustomCGFloatPreferenceKey.self,
                            value: dimension == .width ? geo.size.width : geo.size.height
                        )
                        .onPreferenceChange(CustomCGFloatPreferenceKey.self) {
                            binding.wrappedValue = $0
                        }
                }
            )
    }
    
    // MARK: - geometryReaderSizeViewModifier
    func geometryReaderSizeViewModifier(_ binding: Binding<CGSize>) -> some View {
        self
            .background(
                GeometryReader { geo in
                    Color.clear
                        .preference(key: CustomCGSizePreferenceKey.self, value: geo.size)
                        .onPreferenceChange(CustomCGSizePreferenceKey.self) {
                            binding.wrappedValue = $0
                        }
                }
            )
    }
    
    // MARK: - sheetTopTrailingCloseButtonViewModifier
    func sheetTopTrailingCloseButtonViewModifier(color xmarkColor: Color = .primary, isVisible: Bool = true, action: @escaping () -> Void) -> some View {
        self
            .overlay(alignment: .topTrailing) {
                if isVisible {
                    Button {
                        action()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(xmarkColor)
                            .frame(width: 35)
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
    func registerProfileTapEvent(event: Profile_TapEventTypes, action: @escaping () -> Void) -> some View {
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
    }
    
    // MARK: - presentStatusCircleHandler
    @ViewBuilder
    func presentStatusCircleHandler(isPrimary: Bool, isOnline: Bool) -> some View {
        let vm: ProfileVM = .shared
        let ratio: CGFloat = vm.profilePhotoOffsetRatio
        var lineWidth: CGFloat {
            let value:  CGFloat = vm.secondaryProfilePhotoBorderSize
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
                        .stroke(.tabBarNSystemBackground, lineWidth: lineWidth)
                        .fill(.presentStatus)
                        .frame(width: frame, height: frame)
                        .offset(x: offset, y: offset)
                }
            }
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
