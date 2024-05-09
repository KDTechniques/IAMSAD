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
    
    let model: MessageBubbleValues.MessageBubbleModel
    let content: T
    
    // MARK: - PRIVATE PROPERTIES
    let values = MessageBubbleValues.self
    
    // MARK: - INITIALIZER
    init(_ model: MessageBubbleValues.MessageBubbleModel, @ViewBuilder content: () -> T) {
        self.model = model
        self.content = content()
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if model.isForwarded { Conversations_ForwardedTextView() }
            content
        }
        .padding(
            [model.direction == .left ? .leading : .trailing],
            values.bubbleShapeValues.pointerWidth
        )
        .background(model.direction == .right ? .bubbleSender : .bubbleReceiver)
        .clipShape(
            Conversations_BubbleShape(
                direction: model.direction,
                showPointer: model.showPointer
            )
        )
        .conversationsBubbleShadowViewModifier(colorScheme) {
            AnyShape(
                Conversations_BubbleShape(
                    direction: model.direction,
                    showPointer: model.showPointer
                )
            )
        }
        .frame(maxWidth: .infinity, alignment: model.direction == .left ? .leading : .trailing)
        .padding(
            [model.direction == .left ? .leading : .trailing],
            values.screenToBubblePadding
        )
        .padding(
            [model.direction == .left ? .trailing : .leading],
            values.maxWidthLimitationPadding
        )
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_MessageBubbleView") {
    ZStack {
        Color.conversationBackground
            .ignoresSafeArea()
        
        let obj: MessageBubbleValues.MessageBubbleModel = .getRandomMockObject(true, true)
        Conversations_MessageBubbleView(obj) {
            HStack {
                Text("Hi there 👋👋👋") // don't add any more text as this will not go to a second line properly here. For testing purposes only.
                
                Conversations_BubbleEditedTimestampReadReceiptsView(obj)
            }
            .messageBubbleContentDefaultPadding
        }
        
        Rectangle()
            .fill(Color.debug)
            .frame(width: MessageBubbleValues.maxContentWidth, height: 5)
            .frame(width: screenWidth, alignment: obj.direction == .right ? .trailing : .leading)
            .offset(
                x: MessageBubbleValues.screenToBubblePadding * (obj.direction == .right ? -1 : 1),
                y: 40
            )
    }
}
