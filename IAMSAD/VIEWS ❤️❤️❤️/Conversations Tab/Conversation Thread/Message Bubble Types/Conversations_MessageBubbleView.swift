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
    @Environment(\.colorScheme) private var colorScheme
    
    let direction: BubbleShapeValues.Directions
    let showPointer: Bool
    let content: () -> T
    
    let values = MessageBubbleValues.self
    
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
            .padding([direction == .left ? .leading : .trailing], values.bubbleShapeValues.pointerWidth)
            .background(direction == .right ? .bubbleSender : .bubbleReceiver)
            .clipShape(Conversations_BubbleShape(direction: direction, showPointer: showPointer))
            .conversationsBubbleShadowViewModifier(colorScheme) {
                AnyShape(Conversations_BubbleShape(direction: direction, showPointer: showPointer))
            }
            .frame(maxWidth: .infinity, alignment: direction == .left ? .leading : .trailing)
            .padding([direction == .left ? .leading : .trailing], values.screenToBubblePadding)
            .padding([direction == .left ? .trailing : .leading], values.maxWidthLimitationPadding)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_MessageBubbleView") {
    ZStack {
        Color.conversationBackground
            .ignoresSafeArea()
        
        Conversations_MessageBubbleView(direction: .right, showPointer: true) {
            VStack(alignment: .trailing, spacing: 2) {
                Text("Hi there 👋👋👋")
                
                Conversations_BubbleEditedTimestampReadReceiptsView(timestamp: "12:35 PM", status: .seen, shouldAnimate: false)
            }
            .padding(12)
        }
    }
}
