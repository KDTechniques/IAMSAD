//
//  Conversations_SharedAudioPrimaryPlainBubble_ImageView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-06.
//

import SwiftUI

struct Conversations_SharedAudioPrimaryPlainBubble_ImageView: View {
    // MARK: - PROPERTIES
    let direction: BubbleShapeValues.Directions
    
    // MARK: - INITIALIZER
    init(direction: BubbleShapeValues.Directions) {
        self.direction = direction
    }
    
    // MARK: - PRIVATE PROPERTIES
    let values = VoiceRecordNAudioBubbleValues.self
    
    // MARK: - BODY
    var body: some View {
        Image(.musicNote)
            .renderingMode(.template)
            .offset(x: -2)
            .frame(width: values.imageSize, height: values.imageSize)
            .background(.musicNoteBackground.gradient)
            .clipShape(Circle())
            .foregroundStyle(.white.gradient)
            .offset(x: values.getImageOffsetX(direction))
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_SharedAudioPrimaryPlainBubble_ImageView") {
    Conversations_SharedAudioPrimaryPlainBubble_ImageView(direction: .right)
}
