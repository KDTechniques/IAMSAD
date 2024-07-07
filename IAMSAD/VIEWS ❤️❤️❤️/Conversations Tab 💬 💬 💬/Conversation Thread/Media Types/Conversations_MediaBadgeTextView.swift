//
//  Conversations_MediaBadgeTextView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-14.
//

import SwiftUI

struct Conversations_MediaBadgeTextView: View {
    // MARK: - PROPERTIES
    let text: String
    
    // MARK: - INITIALIZER
    init(text: String) {
        self.text = text
    }
    
    // MARK: - BODY
    var body: some View {
        Text(text)
            .font(MessageBubbleValues.mediaTypeFont)
            .foregroundStyle(.secondary)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_MediaBadgeTextView") {
    Conversations_MediaBadgeTextView(text: "Photo")
        .previewViewModifier
}
