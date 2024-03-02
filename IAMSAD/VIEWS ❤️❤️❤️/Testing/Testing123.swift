//
//  Testing123.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-14.
//

import SwiftUI
import BBSwiftUIKit

struct Testing123: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var contentOffset: CGPoint
    @Binding var tapCoordinates: CGPoint
    let topContentHeight: CGFloat
    
    @State var horizontalTabHeight: CGFloat = .zero
    @State var contentStaticMinY: CGFloat = .zero
    
    let profileTab: ProfileTab = .shared
    
    var body: some View {
        CustomStripTabView(
            horizontalTabHeight: $horizontalTabHeight,
            contentArray: [
                .init(content: AnyView(
                    
                    BBScrollView(.vertical, contentOffset: $contentOffset.handleContentOffset()) {
                        LazyVStack(spacing: 0) {
                            let frameHeight: CGFloat = topContentHeight-contentStaticMinY+horizontalTabHeight
                            Color(colorScheme == .dark ? .black : .white)
                                .opacity(0.01)
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
                                .onTapGesture {
                                    let correctedY: CGFloat = $0.y + contentStaticMinY - contentOffset.y
                                    tapCoordinates = .init(x: $0.x, y: correctedY)
                                }
                            
                            LazyVStack(spacing: 50) {
                                ForEach(0...150, id: \.self) { index in
                                    Button(index.description) {
                                        print(index)
                                    }
                                    .frame(width: screenWidth)
                                }
                                .padding(.top)
                            }
                        }
                        .frame(width: screenWidth)
                    }
                        .bb_showsVerticalScrollIndicator(false)
                    
                ), label: "Posts"),
                .init(content: AnyView(
                    
                    BBScrollView(.vertical, contentOffset: $contentOffset.handleContentOffset()) {
                        LazyVStack(spacing: 0) {
                            let frameHeight: CGFloat = topContentHeight-contentStaticMinY+horizontalTabHeight
                            Color(colorScheme == .dark ? .black : .white)
                                .opacity(0.01)
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
                                .onTapGesture {
                                    let correctedY: CGFloat = $0.y + contentStaticMinY - contentOffset.y
                                    tapCoordinates = .init(x: $0.x, y: correctedY)
                                }
                            
                            LazyVStack(spacing: 50) {
                                ForEach(0...100, id: \.self) { index in
                                    Button(index.description) {
                                        print(index)
                                    }
                                    .frame(width: screenWidth)
                                }
                                .padding(.top)
                            }
                        }
                        .frame(width: screenWidth)
                    }
                        .bb_showsVerticalScrollIndicator(false)
                    
                    
                    
                ), label: "Replies")
                
                
            ], horizontalTabOffsetY: topContentHeight - profileTab.throttledContentOffset.y)
    }
}

#Preview {
    Preview()
}

fileprivate struct Preview: View {
    @State var contentOffset: CGPoint = .zero
    @State var tapCoordinates: CGPoint = .zero
    
    var body: some View {
        Testing123(
            contentOffset: $contentOffset,
            tapCoordinates: $tapCoordinates,
            topContentHeight: 450
        )
    }
}

extension Binding<CGPoint> {
    func handleContentOffset() -> Binding<CGPoint> {
        Binding {
            self.wrappedValue
        } set: { newValue in
            let profileTab: ProfileTab = .shared
            let conditionValue: CGFloat = profileTab.profileContentHeight -
            profileTab.coverPhotoFrameStaticMaxY - profileTab.coverMaxExtraHeight

            if self.wrappedValue.y <= conditionValue {
                DispatchQueue.main.async {
                    return self.wrappedValue = newValue
                }
            }
            
            if newValue.y <= conditionValue {
                DispatchQueue.main.async {
                    return self.wrappedValue = newValue
                }
            }
            
        }
    }
}
