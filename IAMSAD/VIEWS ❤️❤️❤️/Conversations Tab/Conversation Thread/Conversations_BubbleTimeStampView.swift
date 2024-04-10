//
//  Conversations_BubbleTimeStampView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-10.
//

import SwiftUI

struct Conversations_BubbleTimeStampView: View {
    // MARK: - PROPERTIES
    let time: String
    
    // MARK: - INITIALIZER
    init(_ time: String) {
        self.time = time
    }
    
    // MARK: - BODY
    var body: some View {
        Text(time)
            .font(.caption)
            .kerning(0.3)
            .foregroundStyle(.secondary)
            .padding(.bottom, -2)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_BubbleTimeStampView") {
    Conversations_BubbleTimeStampView("11.34 AM")
}
