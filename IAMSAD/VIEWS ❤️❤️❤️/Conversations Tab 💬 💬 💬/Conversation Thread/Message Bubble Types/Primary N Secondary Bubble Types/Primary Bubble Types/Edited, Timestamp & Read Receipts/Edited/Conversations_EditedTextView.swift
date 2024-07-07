//
//  Conversations_EditedTextView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-01.
//

import SwiftUI

struct Conversations_EditedTextView: View {
    // MARK: - PROPERTIES
    let font: Font = MessageBubbleValues.timestampFont
    
    // MARK: - BODY
    var body: some View {
        Text("Edited")
            .font(font)
            .foregroundStyle(.secondary)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_EditedTextView") {
    Conversations_EditedTextView()
        .previewViewModifier
}
