//
//  Conversations_RegularMessageBubbleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-09.
//

import SwiftUI

struct Conversations_RegularMessageBubbleView<T: View>: View {
    // MARK: - PROPERTIES
    let direction: BubbleShapeValues.Directions
    let content: () -> T
    
    let values: BubbleShapeValues = .init()
    
    // MARK: - INITIALIZER
    init(direction: BubbleShapeValues.Directions, @ViewBuilder content: @escaping () -> T) {
        self.content = content
        self.direction = direction
    }
    
    // MARK: - BODY
    var body: some View {
        content()
            .padding([direction == .left ? .leading : .trailing], values.externalWidth)
            .background(.regularBubble)
            .clipShape(Conversations_BubbleShape(direction: direction))
            .frame(maxWidth: .infinity, alignment: direction == .left ? .leading : .trailing)
            .padding([direction == .left ? .leading : .trailing], 10)
            .padding([direction == .left ? .trailing : .leading], 80)
    }
}
