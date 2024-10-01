//
//  Conversations_DeletedPrimaryPlainBubbleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-01.
//

import SwiftUI

struct Conversations_DeletedPrimaryPlainBubbleView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    let model: MessageBubbleValues.MessageBubbleModel
    let isDeleting: Bool
    
    // MARK: - PRIVATE PROPERTIES
    let values = MessageBubbleValues.self
    
    // MARK: - INITIALIZER
    init(model: MessageBubbleValues.MessageBubbleModel, isDeleting: Bool) {
        self.model = model
        self.isDeleting = isDeleting
    }
    
    // MARK: - BODY
    var body: some View {
        Conversations_MessageBubbleView(model) {
            HStack(alignment: .bottom, spacing: 12) {
                HStack(spacing: 2) {
                    Image(systemName: "nosign")
                        .font(.footnote.weight(.bold))
                        .foregroundStyle(.noSign)
                    
                    Text("You deleted this message.")
                        .font(.subheadline)
                        .italic()
                        .foregroundStyle(.deletedMessageText)
                }
                
                Conversations_BubbleEditedTimestampReadReceiptsView(.init(
                    direction: model.direction,
                    showPointer: model.showPointer,
                    timestamp: model.timestamp,
                    status: isDeleting ? .pending : .none
                ))
            }
            .padding(.horizontal, values.innerHPadding)
            .padding(.vertical, values.innerVPaddingTimestampOnly)
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_DeletedPrimaryPlainBubbleView") {
    BubbleVariator_Preview {
        Conversations_DeletedPrimaryPlainBubbleView(
            model: .init(
                direction: $0 ? .left : .right,
                showPointer: false,
                timestamp: "11:15 PM",
                status: .none
            ),
            isDeleting: .random()
        )
    }
    .previewViewModifier
}
