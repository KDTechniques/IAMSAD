//
//  CustomStripTabHorizontalScrollView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-13.
//

import SwiftUI

struct CustomStripTabHorizontalScrollView: View {
    // MARK: - PROPERTIES
    @Binding var tabSelection: Int
    @Binding var currentGesture: CustomStripTabGestureTypes
    let tabContentMinXArray: [CGFloat]
    let tabLabelsArray: [Profile_TabLabelTypes]
    let font: Font
    let showDivider: Bool
    let stripExtraWidth: CGFloat
    let labelToStripSpacing: CGFloat
    let horizontalSpacing: CGFloat
    let labelSpacing: CGFloat
    
    @State private var tabLabelWidthArray: [CGFloat]
    @State private var tabLabelMidXArray: [CGFloat]
    
    @State private var horizontalScrollViewHeight: CGFloat = .zero
    let capsuleHeight: CGFloat = 3
    let minimumTabLabelOpacity: CGFloat = 0.6
    var tabCount: Int { tabLabelsArray.count }
    @State var contentOffset: CGPoint = .zero
    @State var animatedContentOffset: CGPoint? = nil
    @State var horizontalScrollViewStaticWidth: CGFloat = .zero
    
    // MARK: - INITIALIZER
    init(
        tabSelection: Binding<Int>,
        currentGesture: Binding<CustomStripTabGestureTypes>,
        tabContentMinXArray: [CGFloat],
        tabLabelsArray: [Profile_TabLabelTypes],
        font: Font,
        showDivider: Bool,
        stripExtraWidth: CGFloat,
        labelToStripSpacing: CGFloat,
        horizontalSpacing: CGFloat,
        labelSpacing: CGFloat
    ) {
        _tabSelection = tabSelection
        _currentGesture = currentGesture
        self.tabContentMinXArray = tabContentMinXArray
        self.tabLabelsArray = tabLabelsArray
        self.font = font
        self.showDivider = showDivider
        self.stripExtraWidth = stripExtraWidth
        self.labelToStripSpacing = labelToStripSpacing
        self.horizontalSpacing = horizontalSpacing
        self.labelSpacing = labelSpacing
        
        var tempArray: [CGFloat] = []
        for _ in 1...tabLabelsArray.count { tempArray.append(.zero) }
        self.tabLabelMidXArray = tempArray
        self.tabLabelWidthArray = tempArray
    }
    
    // MARK: - BODY
    var body: some View {
        CustomUIScrollView(.horizontal, contentOffset: $contentOffset) {
            HStack(spacing: labelSpacing) {
                ForEach(tabLabelsArray.indices, id: \.self) { index in
                    // MARK: TAB LABEL
                    Text(tabLabelsArray[index].rawValue.capitalized)
                        .font(font)
                        .opacity(getTabLabelOpacity(index))
                        .background { assignTabLabelMidX(index) }
                        .background { assignTabLabelWidth(index) }
                        .onTapGesture { handleTap(index) }
                }
            }
            .padding(.horizontal, horizontalSpacing)
            .geometryReaderDimensionViewModifier($horizontalScrollViewStaticWidth, dimension: .width)
            .padding(.vertical, labelToStripSpacing)
            .background { getHorizontalScrollViewHeight }
        }
        .contentOffsetToScrollAnimated($animatedContentOffset)
        .showsHorizontalScrollIndicator(false)
        .overlay { capsule }
        .overlay(alignment: .bottom) { Divider().opacity(showDivider ? 1 : 0) }
        .onChange(of: tabContentMinXArray) { _, _ in
            setContentOffsetX()
        }
    }
}

// MARK: - PREVIEWS
#Preview("CustomStripTabView") { CustomStripTabView_Preview() }

// MARK: - EXTENSIONS - PRIVATE
extension CustomStripTabHorizontalScrollView {
    // MARK: - capsule
    private var capsule: some View {
        Capsule()
            .fill(.accent)
            .frame(width: getCapsuleWidth(), height: capsuleHeight)
            .position(
                x: getCapsulePositionX(),
                y: horizontalScrollViewHeight - capsuleHeight/2
            )
            .animation(.default, value: tabSelection)
    }
    
    // MARK: - getHorizontalScrollViewHeight
    private var getHorizontalScrollViewHeight: some View {
        GeometryReader { geo in
            Color.clear
                .preference(key: CustomCGFloatPreferenceKey.self, value: geo.size.height)
                .onPreferenceChange(CustomCGFloatPreferenceKey.self) { horizontalScrollViewHeight = $0 }
        }
    }
    
    // MARK: - assignTabLabelWidth
    private func assignTabLabelWidth(_ index: Int) -> some View {
        GeometryReader { geo in
            Color.clear
                .preference(
                    key: CustomCGFloatPreferenceKey.self,
                    value: geo.size.width + stripExtraWidth
                )
                .onPreferenceChange(CustomCGFloatPreferenceKey.self) {
                    tabLabelWidthArray[index] = $0
                }
        }
    }
    
    // MARK: - assignTabLabelMidX
    private func assignTabLabelMidX(_ index: Int) -> some View {
        GeometryReader { geo in
            Color.clear
                .preference(
                    key: CustomCGFloatPreferenceKey.self,
                    value: geo.frame(in: .global).midX
                )
                .onPreferenceChange(CustomCGFloatPreferenceKey.self) {
                    tabLabelMidXArray[index] = $0
                }
        }
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - getTabLabelOpacity
    private func getTabLabelOpacity(_ tabIndex: Int) -> CGFloat {
        let index: Int = tabContentMinXArray.firstIndex(where: { $0 != .zero }) ?? tabSelection
        var staticDif: CGFloat = .zero
        var dynamicDif: CGFloat = .zero
        var calculation: CGFloat = .zero
        
        if index == tabCount-1 {
            staticDif = tabLabelMidXArray[index].rounded()
            dynamicDif = tabLabelMidXArray[index].rounded()
        } else {
            staticDif = (tabLabelMidXArray[index+1]-tabLabelMidXArray[index]).rounded()
            dynamicDif = ((tabLabelMidXArray[index+1]-tabLabelMidXArray[index]) * tabContentMinXArray[index]/screenWidth).rounded()
            
            calculation = (dynamicDif/staticDif) * (1-minimumTabLabelOpacity)
        }
        
        return minimumTabLabelOpacity + ( // to all tabs
            // stable selected tab
            index == tabIndex && dynamicDif == 0
            ? (1-minimumTabLabelOpacity)
            
            // user is interacting, selected tab
            : index == tabIndex ? -minimumTabLabelOpacity + (1-calculation)
            
            // user is interacting, next tab
            : index+1 == tabIndex ? calculation : 0
        )
    }
    
    // MARK: - getCapsulePositionX
    private func getCapsulePositionX() -> CGFloat {
        /// tab1LabelMidX + ((tab2LabelMidX-tab1LabelMidX) * tab1ContentMinX/screenWidth)
        /// first find the tabContentMinX index that's not equal to zero, so that's the absolute selected tab, and assign it to the index variable below to work with smooth animations.
        let index: Int = tabContentMinXArray.firstIndex(where: { $0 != .zero }) ?? tabSelection
        
        if index == tabCount-1 {
            return tabLabelMidXArray[index]
        } else {
            return tabLabelMidXArray[index] + ((tabLabelMidXArray[index+1]-tabLabelMidXArray[index]) * tabContentMinXArray[index]/screenWidth)
        }
    }
    
    // MARK: - getCapsuleWidth
    private func getCapsuleWidth() -> CGFloat {
        let index: Int = tabContentMinXArray.firstIndex(where: { $0 != .zero }) ?? tabSelection
        var staticDif: CGFloat = .zero
        var dynamicDif: CGFloat = .zero
        var calculation: CGFloat = .zero
        
        if index == tabCount-1 {
            staticDif = tabLabelMidXArray[index].rounded()
            dynamicDif = tabLabelMidXArray[index].rounded()
            
            calculation =  tabLabelWidthArray[index]
        } else {
            staticDif = (tabLabelMidXArray[index+1]-tabLabelMidXArray[index]).rounded()
            dynamicDif = ((tabLabelMidXArray[index+1]-tabLabelMidXArray[index]) * tabContentMinXArray[index]/screenWidth).rounded()
            
            calculation = tabLabelWidthArray[index] + ((dynamicDif/staticDif) * (tabLabelWidthArray[index+1]-tabLabelWidthArray[index]))
        }
        
        return calculation.isNaN ? .zero : calculation
    }
    
    // MARK: - handleTabSelectionScroll
    private func handleTabSelectionScroll(proxy: ScrollViewProxy, value: Int) {
        withAnimation { proxy.scrollTo(value, anchor: .center) }
    }
    
    // MARK: - setContentOffsetX
    private func setContentOffsetX(_ isAnimated: Bool = false) {
        let tabsCount: CGFloat = CGFloat(tabContentMinXArray.count-1)
        let calculation1: CGFloat = (horizontalScrollViewStaticWidth - screenWidth) / tabsCount
        var tabIndex: Int {
            if let firstIndex: Int = tabContentMinXArray.firstIndex(where: { $0 > 0 }) {
                return firstIndex
            } else {
                return tabSelection
            }
        }
        let calculation2: CGFloat = CGFloat(tabIndex) + (tabContentMinXArray[tabIndex] / screenWidth)
        let calculation3: CGFloat = calculation1 * (calculation2 > tabsCount ? tabsCount : calculation2)
        
        if !isAnimated {
            contentOffset.x = calculation3
        } else {
            animatedContentOffset = .init(x: calculation3, y: 0)
        }
    }
    
    // MARK: - handleTap
    private func handleTap(_ index: Int) {
        currentGesture = .tap
        tabSelection = index
        setContentOffsetX(true)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            currentGesture = .drag
        }
    }
}
