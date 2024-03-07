//
//  Testing123.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-14.
//

import SwiftUI

struct Testing123: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var profileVM: ProfileViewModel
    
    @Binding var contentOffset: CGPoint
    @Binding var tapCoordinates: CGPoint
    let topContentHeight: CGFloat
    
    @State var horizontalTabHeight: CGFloat = .zero
    @State var contentStaticMinY: CGFloat = .zero
    
    // MARK: - BODY
    var body: some View {
        CustomStripTabView(
            horizontalTabHeight: $horizontalTabHeight,
            contentArray: [
                .init(content: AnyView(
                    CustomUIScrollView(.vertical, contentOffset: $contentOffset.handleContentOffset()) {
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
                        .showsVerticalScrollIndicator(false)
                ), label: "Posts"),
                .init(content: AnyView(
                    CustomUIScrollView(.vertical, contentOffset: $contentOffset.handleContentOffset()) {
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
                        .showsVerticalScrollIndicator(false)
                ), label: "Replies"),
                .init(content: AnyView(
                    CustomUIScrollView(.vertical, contentOffset: $contentOffset.handleContentOffset()) {
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
                        .showsVerticalScrollIndicator(false)
                ), label: "Media"),
                .init(content: AnyView(
                    CustomUIScrollView(.vertical, contentOffset: $contentOffset.handleContentOffset()) {
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
                        .showsVerticalScrollIndicator(false)
                ), label: "Likes"),
                .init(content: AnyView(
                    CustomUIScrollView(.vertical, contentOffset: $contentOffset.handleContentOffset()) {
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
                        .showsVerticalScrollIndicator(false)
                ), label: "Bookmarks"),
                .init(content: AnyView(
                    CustomUIScrollView(.vertical, contentOffset: $contentOffset.handleContentOffset()) {
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
                        .showsVerticalScrollIndicator(false)
                ), label: "Achievements"),
            ], horizontalTabOffsetY: topContentHeight - profileVM.throttledContentOffset.y)
    }
}

#Preview {
    Preview()
        .previewViewModifier
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
            DispatchQueue.main.async {
                let profileVM: ProfileViewModel = .shared
                let conditionValue: CGFloat = profileVM.profileContentHeight -
                profileVM.coverPhotoFrameStaticMaxY - profileVM.coverMaxExtraHeight
                
                if self.wrappedValue.y <= conditionValue {
                    return self.wrappedValue = newValue
                }
                
                if newValue.y <= conditionValue {
                    return self.wrappedValue = newValue
                }
            }
        }
    }
}
