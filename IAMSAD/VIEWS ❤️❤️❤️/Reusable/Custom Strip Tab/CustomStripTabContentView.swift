//
//  CustomStripTabContentView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-13.
//

import SwiftUI

struct CustomStripTabContentView: View {
    // MARK: - PROPERTIES
    @Binding var tabSelection: Int
    @Binding var tabContentMinXArray: [CGFloat]
    let currentGesture: CustomStripTabGestureTypes
    let contentArray: [CustomStripTabModel]
    var tabsArray: [Profile_TabLabelTypes] {
        contentArray.map({ $0.label })
    }
    
    // MARK: - INITIALIZER
    init(
        tabSelection: Binding<Int>,
        tabContentMinXArray: Binding<[CGFloat]>,
        currentGesture: CustomStripTabGestureTypes,
        contentArray: [CustomStripTabModel]
    ) {
        _tabContentMinXArray = tabContentMinXArray
        _tabSelection = tabSelection
        self.currentGesture = currentGesture
        self.contentArray = contentArray
    }
    
    // MARK: - BODY
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(contentArray.indices, id: \.self) { index in
                        contentArray[index].content
                            .frame(width: screenWidth)
                    }
                }
                .background { assignTabContentMinX() }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
            .onChange(of: tabSelection) { handleScrollProxy(proxy: proxy, index: $1) }
        }
    }
}

// MARK: - PREVIEWS
#Preview("CustomStripTabView") {
    CustomStripTabView_Preview()
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension CustomStripTabContentView {
    // MARK: - assignTabContentMinX
    @MainActor
    private func assignTabContentMinX() -> some View {
        GeometryReader { geo in
            Color.clear
                .preference(
                    key: CustomCGFloatPreferenceKey.self,
                    value: geo.frame(in: .global).minX
                )
            
        }
        .onPreferenceChange(CustomCGFloatPreferenceKey.self) { value in
            let index: Int = Int(abs(value/screenWidth))
            let absValue: CGFloat = abs(value + (screenWidth*CGFloat(index)))
            
            tabContentMinXArray.indices.forEach({
                if index != $0 {
                    tabContentMinXArray[$0] = 0
                }
            })
            
            if value <= 0 {
                if absValue == 0 {
                    if index-1 >= 0 {
                        tabContentMinXArray[index-1] = screenWidth
                    }
                }
                
                tabContentMinXArray[index] = absValue
            }
            
            if currentGesture == .drag {
                if Int(abs(value)).isMultiple(of: Int(screenWidth)) {
                    tabSelection = index
                    ProfileViewModel.shared.selectedTabType = contentArray.map({ $0.label })[index]
                }
            }
        }
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - handleScrollProxy
    private func handleScrollProxy(proxy: ScrollViewProxy, index: Int) {
        withAnimation {
            proxy.scrollTo(index)
        }
    }
}
