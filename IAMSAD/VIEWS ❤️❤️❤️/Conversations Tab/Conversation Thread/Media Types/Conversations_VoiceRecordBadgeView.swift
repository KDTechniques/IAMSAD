//
//  Conversations_VoiceRecordBadgeView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-14.
//

import SwiftUI

struct Conversations_VoiceRecordBadgeView: View {
    // MARK: - PROPERTIES
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    let duration: String
    
    let values = MessageBubbleValues.self
    var height: CGFloat { values.mediaTypeFontHeight(dynamicTypeSize) }
    
    // MARK: - INITIALIZER
    init(duration: String) {
        self.duration = duration
    }
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: values.mediaTypeIconToTextHPadding) {
            Image(systemName: "mic.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.mic)
                .frame(height: height)
            
            Conversations_MediaBadgeTextView(text: "0:02")
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_VoiceRecordBadgeView") {
    Conversations_VoiceRecordBadgeView(duration: "1:04")
}
