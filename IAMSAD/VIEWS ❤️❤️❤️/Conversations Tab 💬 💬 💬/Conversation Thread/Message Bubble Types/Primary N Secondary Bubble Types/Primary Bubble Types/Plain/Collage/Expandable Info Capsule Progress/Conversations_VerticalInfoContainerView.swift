//
//  Conversations_VerticalInfoContainerView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-06-22.
//

import SwiftUI

struct Conversations_VerticalInfoContainerView: View {
    // MARK: - PROPERTIES
    let totalSize: String
    let itemsCount: Int
    let isCompressed: Bool
    let circleSize: CGFloat
    let action: () -> Void
    
    // MARK: - INITIALIZER
    init(
        totalSize: String,
        itemsCount: Int,
        isCompressed: Bool,
        circleSize: CGFloat,
        action: @escaping () -> Void
    ) {
        self.totalSize = totalSize
        self.itemsCount = itemsCount
        self.isCompressed = isCompressed
        self.circleSize = circleSize
        self.action = action
    }
    
    // MARK: - BODY
    var body: some View {
        VContainer(totalSize: totalSize, itemsCount: itemsCount)
            .opacity(isCompressed ? 0 : 1)
            .padding(.leading, isCompressed ? 0 : circleSize)
            .padding(.trailing, isCompressed ? 0 : circleSize/2)
            .onTapGesture { action() }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_VerticalInfoContainerView") {
    Conversations_VerticalInfoContainerView(
        totalSize: "16.1 MB",
        itemsCount: .random(in: 4...10),
        isCompressed: false,
        circleSize: StandardMediaCircularProgressValues.frameSize
    ) { print("Tapped.") }
        .previewViewModifier
}

// MARK: - SUBVIEWS

// MARK: - VContainer
fileprivate struct VContainer: View {
    // MARK: - PROPERTIES
    let totalSize: String
    let itemsCount: Int
    
    // MARK: - INITIALIZER
    init(totalSize: String, itemsCount: Int) {
        self.totalSize = totalSize
        self.itemsCount = itemsCount
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(totalSize)
                .fontWeight(.medium)
                .fixedSize()
            
            Text("\(itemsCount) items")
                .fontWeight(.light)
                .fixedSize()
        }
    }
}
