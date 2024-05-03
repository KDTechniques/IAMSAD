//
//  Conversations_VoiceRecordPrimaryPlainBubble_ActionButtonsView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-03.
//

import SwiftUI

struct Conversations_VoiceRecordPrimaryPlainBubble_ActionButtonsView: View {
    // MARK: - PROPERTIES
    let actionType: VoiceRecordBubbleValues.ActionTypes
    let action: () -> Void
    
    // MARK: - PRIVATE PROPERTIES
    let values = VoiceRecordBubbleValues.self
    var iconName: String {
        switch actionType {
        case .play:
            "play.fill"
        case .pause:
            "pause.fill"
        case .cancel:
            "xmark"
        }
    }
    
    // MARK: - INITILAIZER
    init(actionType: VoiceRecordBubbleValues.ActionTypes, action: @escaping () -> Void) {
        self.actionType = actionType
        self.action = action
    }
    
    // MARK: - BODY
    var body: some View {
        Image(systemName: iconName)
            .resizable()
            .scaledToFit()
            .frame(width: values.playPauseIconsWidth)
            .foregroundStyle(.micPlaybackNCancelIcons)
            .padding(.horizontal, 10)
            .onTapGesture { action() }
    }
}

#Preview("Conversations_VoiceRecordPrimaryPlainBubble_ActionButtonsView") {
    Conversations_VoiceRecordPrimaryPlainBubble_ActionButtonsView(actionType: .play) {
        print("Clicked!")
    }
    .previewViewModifier
}
