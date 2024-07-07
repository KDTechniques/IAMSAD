//
//  Conversations_ExpandableInfoCapsuleProgressView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-06-22.
//

import SwiftUI

struct Conversations_ExpandableInfoCapsuleProgressView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var isCompressed: Bool
    let totalSize: String
    let itemsCount: Int
    let defaultAction: () -> Void
    let cancelAction: () -> Void
    
    // MARK: - PRIVATE PROPERTIES
    let progressValues = StandardMediaCircularProgressValues.self
    var circleSize: CGFloat { progressValues.frameSize }
    var animation: Animation { progressValues.expandableAnimation }
    
    // MARK: - INITIALIZER
    init(
        isCompressed: Binding<Bool>,
        totalSize: String,
        itemsCount: Int,
        defaultAction: @escaping () -> Void,
        cancelAction:  @escaping () -> Void
    ) {
        _isCompressed = isCompressed
        self.totalSize = totalSize
        self.itemsCount = itemsCount
        self.defaultAction = defaultAction
        self.cancelAction = cancelAction
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: isCompressed ? .center : .leading) {
            verticalInfoContainer
            circularProgress
        }
        .font(.footnote)
        .foregroundStyle(.arrowDown)
        .frame(width: isCompressed ? circleSize : nil)
        .standardCircularProgressBackgroundViewModifier(colorScheme)
        .clipShape(Capsule())
        .animation(animation, value: isCompressed)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_ExpandableInfoCapsuleProgressView") {
    @Previewable @State var isCompressed: Bool = false
    
    Conversations_ExpandableInfoCapsuleProgressView(
        isCompressed: $isCompressed,
        totalSize: "16.1 MB",
        itemsCount: .random(in: 4...10)) {
            isCompressed.toggle()
            print("Download Started.")
        } cancelAction: {
            isCompressed.toggle()
            print("Downloads Cancelled.")
        }
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension Conversations_ExpandableInfoCapsuleProgressView {
    // MARK: - verticalInfoContainer
    private var verticalInfoContainer: some View {
        Conversations_VerticalInfoContainerView(
            totalSize: totalSize,
            itemsCount: itemsCount,
            isCompressed: isCompressed,
            circleSize: circleSize
        ) { handleTapGesture() }
    }
    
    // MARK: - circularProgress
    private var circularProgress: some View {
        StandardMediaCircularProgressView(
            value: 0.75,
            showProgress: isCompressed,
            rotateProgress: true,
            withBackground: false
        ) { handleTapGesture() }
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - handleTapGesture
    private func handleTapGesture() {
        isCompressed ? cancelAction() : defaultAction()
    }
}
