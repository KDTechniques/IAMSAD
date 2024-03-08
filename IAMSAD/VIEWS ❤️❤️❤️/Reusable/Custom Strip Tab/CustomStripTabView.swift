//
//  CustomStripTabView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-11.
//

import SwiftUI

struct CustomStripTabView: View {
    // MARK: - PROPERTIES
    @Binding var horizontalTabHeight: CGFloat
    let contentArray: [CustomStripTabModel]
    let font: Font
    let showDivider: Bool
    let stripExtraWidth: CGFloat
    let labelToStripSpacing: CGFloat
    let horizontalSpacing: CGFloat
    let labelSpacing: CGFloat
    let labelToContentSpacing: CGFloat
    let horizontalTabOffsetY: CGFloat
    
    @State private var tabSelection: Int = .zero
    @State private var currentGesture: CustomStripTabGestureTypes = .drag
    @State private var tabContentMinXArray: [CGFloat]
    
    // MARK: - INITIALIZER
    init(
        horizontalTabHeight: Binding<CGFloat>,
        contentArray: [CustomStripTabModel],
        font: Font = .callout.weight(.semibold),
        showDivider: Bool = true,
        stripExtraWidth: CGFloat = 10,
        labelToStripSpacing: CGFloat = 10,
        horizontalSpacing: CGFloat = 20,
        labelSpacing: CGFloat = 50,
        labelToContentSpacing: CGFloat = 0,
        horizontalTabOffsetY: CGFloat
    ) {
        self._horizontalTabHeight = horizontalTabHeight
        self.contentArray = contentArray
        self.font = font
        self.showDivider = showDivider
        self.stripExtraWidth = stripExtraWidth
        self.labelToStripSpacing = labelToStripSpacing
        self.horizontalSpacing = horizontalSpacing
        self.labelSpacing = labelSpacing
        self.labelToContentSpacing = labelToContentSpacing
        self.horizontalTabOffsetY = horizontalTabOffsetY
        
        var tempArray: [CGFloat] = []
        for _ in 1...contentArray.count { tempArray.append(.zero) }
        self.tabContentMinXArray = tempArray
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            CustomStripTabContentView(
                tabSelection: $tabSelection,
                tabContentMinXArray: $tabContentMinXArray,
                currentGesture: currentGesture,
                contentArray: contentArray
            )
            
            CustomStripTabHorizontalScrollView(
                tabSelection: $tabSelection,
                currentGesture: $currentGesture,
                tabContentMinXArray: tabContentMinXArray,
                tabLabelsArray: contentArray.map({ $0.label }),
                font: font,
                showDivider: showDivider,
                stripExtraWidth: stripExtraWidth,
                labelToStripSpacing: labelToStripSpacing,
                horizontalSpacing: horizontalSpacing,
                labelSpacing: labelSpacing
            )
            .geometryReaderDimensionViewModifier($horizontalTabHeight, dimension: .height)
            .background(.tabBarNSystemBackground)
            .offset(y: horizontalTabOffsetY)
        }
        .frame(width: screenWidth, height: screenHeight)
        .ignoresSafeArea()
    }
}

// MARK: - PREVIEWS
#Preview("CustomStripTabView") { CustomStripTabView_Preview() }

struct CustomStripTabView_Preview: View {
    var body: some View {
        CustomStripTabView(
            horizontalTabHeight: .constant(0),
            contentArray: [
                .init(content: AnyView(
                    ScrollView {
                        VStack(spacing: 150) {
                            ForEach(0...100, id: \.self) {
                                Text($0.description)
                            }
                        }
                        .frame(width: screenWidth)
                    }), label: "Posts"),
                .init(content: AnyView(Color.debug), label: "Replies"),
                .init(content: AnyView(
                    ScrollView {
                        VStack(spacing: 150) {
                            ForEach(0...100, id: \.self) {
                                Text($0.description)
                            }
                        }
                        .frame(width: screenWidth)
                    }), label: "Media"),
                .init(content: AnyView(Color.debug), label: "Likes"),
                .init(content: AnyView(
                    ScrollView {
                        VStack(spacing: 150) {
                            ForEach(0...100, id: \.self) {
                                Text($0.description)
                            }
                        }
                        .frame(width: screenWidth)
                    }), label: "Bookmarks"),
                .init(content: AnyView(Color.debug), label: "Achievements"),
            ],
            horizontalTabOffsetY: 300
        )
        .previewViewModifier
    }
}

// MARK: - GestureTypes
enum CustomStripTabGestureTypes { case tap, drag }

// MARK: - CustomStripTabModel
struct CustomStripTabModel: Identifiable {
    let id: String = UUID().uuidString
    let content: AnyView
    let label: String
}
