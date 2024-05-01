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
    
    let isDeleting: Bool
    
    let values = MessageBubbleValues.self
    
    // MARK: - INITIALIZER
    init(isDeleting: Bool) {
        self.isDeleting = isDeleting
    }
    
    // MARK: - BODY
    var body: some View {
        Conversations_MessageBubbleView(direction: .right, showPointer: true) {
            HStack(alignment: .bottom, spacing: 12) {
                HStack(spacing: 2) {
                    Image(systemName: "nosign")
                        .font(.footnote.weight(.bold))
                        .foregroundStyle(values.specialSecondaryColor(colorScheme))
                    
                    Text("You deleted this message.")
                        .font(.subheadline)
                        .italic()
                        .foregroundStyle(.secondary)
                }
                
                Conversations_BubbleEditedTimestampReadReceiptsView(
                    timestamp: "10:46 PM",
                    status: isDeleting ? .pending : .none,
                    shouldAnimate: false
                )
            }
            .padding(.horizontal, values.innerHPadding)
            .padding(.vertical, values.innerVPaddingTimestampOnly)
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_DeletedPrimaryPlainBubbleView") {
    Conversations_DeletedPrimaryPlainBubbleView(isDeleting: .random())
        .previewViewModifier
}
