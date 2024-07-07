//
//  Conversations_PhotoBadgeView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-14.
//

import SwiftUI

struct Conversations_PhotoBadgeView: View {
    // MARK: - PROPERTIES
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    let values = MessageBubbleValues.self
    var height: CGFloat { values.mediaTypeFontHeight(dynamicTypeSize) - 5 }
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: values.mediaTypeIconToTextHPadding) {
            Image(systemName: "camera.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.secondary)
                .frame(height: height)
            
            Conversations_MediaBadgeTextView(text: "Photo")
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_PhotoBadgeView") {
    Conversations_PhotoBadgeView()
        .previewViewModifier
}
