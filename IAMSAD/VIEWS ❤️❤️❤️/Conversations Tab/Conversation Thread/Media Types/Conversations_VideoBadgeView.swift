//
//  Conversations_VideoBadgeView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-14.
//

import SwiftUI

struct Conversations_VideoBadgeView: View {
    // MARK: - PROPERTIES
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    let values = MessageBubbleValues.self
    var height: CGFloat { values.mediaTypeFontHeight(dynamicTypeSize) - 6 }
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: values.mediaTypeIconToTextHPadding) {
            Image(systemName: "video.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.secondary)
                .frame(height: height)
            
            Conversations_MediaBadgeTextView(text: "Video")
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_VideoBadgeView") {
    Conversations_VideoBadgeView()
        .previewViewModifier
}
