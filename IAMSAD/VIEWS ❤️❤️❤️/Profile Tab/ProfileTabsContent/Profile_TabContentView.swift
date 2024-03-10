//
//  Profile_TabContentView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-10.
//

import SwiftUI

struct Profile_TabContentView<T: View>: View {
    // MARK: - PROPERTIES
    @Binding var contentOffset: CGPoint
    @Binding var contentStaticMinY: CGFloat
    let topContentHeight: CGFloat
    let horizontalTabHeight: CGFloat
    let content: T
    
    // MARK: - INITIALIZER
    init(
        contentOffset: Binding<CGPoint>,
        contentStaticMinY:Binding< CGFloat>,
        topContentHeight: CGFloat,
        horizontalTabHeight: CGFloat,
        @ViewBuilder content: () -> T
    ) {
        self._contentOffset = contentOffset
        self._contentStaticMinY = contentStaticMinY
        self.topContentHeight = topContentHeight
        self.horizontalTabHeight = horizontalTabHeight
        self.content = content()
    }
    
    // MARK: - BODY
    var body: some View {
        CustomUIScrollView(.vertical, contentOffset: $contentOffset.handleContentOffset()) {
            VStack(spacing: 0) {
                let frameHeight: CGFloat = topContentHeight - contentStaticMinY + horizontalTabHeight
                Color.clear
                    .frame(height: frameHeight > 0 ? frameHeight : .zero)
                    .background {
                        GeometryReader { geo in
                            Color.clear
                                .preference(key: CustomCGFloatPreferenceKey.self, value: geo.frame(in: .global).minY)
                                .onPreferenceChange(CustomCGFloatPreferenceKey.self) { value in
                                    if contentStaticMinY == .zero { contentStaticMinY = value }
                                }
                        }
                    }
                
                content
            }
            .frame(width: screenWidth)
        }
        .showsVerticalScrollIndicator(false)
    }
}

// MARK: - EXTENSIONS
@MainActor
fileprivate extension Binding<CGPoint> {
    // MARK: - handleContentOffset
    func handleContentOffset() -> Binding<CGPoint> {
        let profileVM: ProfileViewModel = .shared
        let conditionValue: CGFloat = profileVM.profileContentHeight -
        profileVM.coverStaticHeight - profileVM.coverMaxExtraHeight
        
        return Binding {
            self.wrappedValue
        } set: { newValue in
            if self.wrappedValue.y <= conditionValue {
                return self.wrappedValue = newValue
            }
            
            if newValue.y <= conditionValue {
                return self.wrappedValue = newValue
            }
        }
    }
}
