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
        TabView(selection: $tabSelection) {
            ForEach(contentArray.indices, id: \.self) { index in
                contentArray[index].content
                    .frame(width: screenWidth)
                    .background { assignTabContentMinX(index) }
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.default, value: tabSelection)
    }
}

// MARK: - PREVIEWS
#Preview("CustomStripTabView") { CustomStripTabView_Preview() }

// MARK: - EXTENSIONS
extension CustomStripTabContentView {
    // MARK: - assignTabContentMinX
    private func assignTabContentMinX(_ index: Int) -> some View {
        GeometryReader { geo in
            Color.clear
                .preference(
                    key: CustomCGFloatPreferenceKey.self,
                    value: geo.frame(in: .global).minX
                )
            
        }
        .onPreferenceChange(CustomCGFloatPreferenceKey.self) { value in
            if value <= 0 {
                let value: CGFloat = abs(value)
                tabContentMinXArray.indices.forEach({
                    if $0 != index {
                        tabContentMinXArray[$0] = .zero
                    } else {
                        if currentGesture == .drag {
                            tabContentMinXArray[index] = value
                        }
                    }
                })
            }
        }
    }
}
