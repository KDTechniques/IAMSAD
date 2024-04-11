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
            .padding([direction == .left ? .leading : .trailing], values.bubbleShapeValues.externalWidth)
            .background(direction == .right ? .bubbleSender : .bubbleReceiver)
            .clipShape(Conversations_BubbleShape(direction: direction, showPointer: showPointer))
            .shadowViewModifier
            .background {
                if colorScheme == .light {
                    Conversations_BubbleShape(direction: direction, showPointer: showPointer)
                        .fill(.black.opacity(0.05))
                        .padding(.horizontal, 1)
                        .offset(y: 1.3)
                }
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
        
        Conversations_MessageBubbleView(direction: .random(), showPointer: Bool.random()) {
            Text("Hi there 👋👋👋")
                .padding(12)
        }
    }
}

// MARK: - EXTENSIONS
extension View {
    // MARK: - shadowViewModifier
    @ViewBuilder
    fileprivate var shadowViewModifier: some View {
        let colorScheme: ColorScheme = Environment(\.colorScheme).wrappedValue
        
        if colorScheme == .light {
            self.shadow(color: .black.opacity(0.05), radius: 1)
        } else {
            self
        }
    }
}

// MARK: - OTHER

// MARK: - MessageBubbleValues
struct MessageBubbleValues {
    static let bubbleShapeValues = BubbleShapeValues.self
    static let screenToBubblePadding: CGFloat = 10
    static let maxWidthLimitationPadding: CGFloat = 85
    static func getDirection(_ by: MessageBubbleUserTypes ) -> BubbleShapeValues.Directions {
        by == .sender ? .right : .left
    }
}
