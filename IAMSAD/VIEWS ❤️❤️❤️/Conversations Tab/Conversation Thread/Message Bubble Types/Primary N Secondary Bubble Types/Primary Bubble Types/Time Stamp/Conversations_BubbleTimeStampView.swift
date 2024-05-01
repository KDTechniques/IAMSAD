//
//  Conversations_BubbleTimeStampView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-10.
//

import SwiftUI

struct Conversations_BubbleTimeStampView: View {
    // MARK: - PROPERTIES
    let timestamp: String
    
    let font: Font = MessageBubbleValues.timestampFont
    
    // MARK: - INITIALIZER
    init(_ timestamp: String) {
        self.timestamp = timestamp
    }
    
    // MARK: - BODY
    var body: some View {
        Text(timestamp)
            .font(font)
            .foregroundStyle(.secondary)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_BubbleTimeStampView") {
    Conversations_BubbleTimeStampView("11.34 AM")
}
