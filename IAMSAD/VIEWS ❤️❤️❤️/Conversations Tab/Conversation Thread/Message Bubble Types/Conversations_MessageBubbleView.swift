//
//  Conversations_MessageBubbleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-09.
//

import SwiftUI

// This is the foundation of all the bubble types we can think of.
struct Conversations_MessageBubbleView<T: View>: View {
    // MARK: - PROPERTIES
    let direction: BubbleShapeValues.Directions
    let showPointer: Bool
    let content: () -> T
    
    let values: MessageBubbleValues = .init()
    
    // MARK: - INITIALIZER
    init(
        direction: BubbleShapeValues.Directions,
        showPointer: Bool,
        @ViewBuilder content: @escaping () -> T
    ) {
        self.direction = direction
        self.showPointer = showPointer
        self.content = content
    }
    
    // MARK: - BODY
    var body: some View {
        content()
            .padding([direction == .left ? .leading : .trailing], values.bubbleShapeValues.externalWidth)
            .background(.regularBubble)
            .clipShape(Conversations_BubbleShape(direction: direction, showPointer: showPointer))
            .frame(maxWidth: .infinity, alignment: direction == .left ? .leading : .trailing)
            .padding([direction == .left ? .leading : .trailing], values.screenToBubblePadding)
            .padding([direction == .left ? .trailing : .leading], values.maxWidthLimitationPadding)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_MessageBubbleView") {
    Conversations_MessageBubbleView(direction: .right, showPointer: Bool.random()) {
        Text("Hi there 👋👋👋")
            .padding(12)
    }
}

struct MessageBubbleValues {
    let bubbleShapeValues: BubbleShapeValues = .init()
    let screenToBubblePadding: CGFloat = 10
    let maxWidthLimitationPadding: CGFloat = 85
    
    func getDirection(_ by: MessageBubbleUserTypes ) -> BubbleShapeValues.Directions {
        by == .sender ? .right : .left
    }
}
