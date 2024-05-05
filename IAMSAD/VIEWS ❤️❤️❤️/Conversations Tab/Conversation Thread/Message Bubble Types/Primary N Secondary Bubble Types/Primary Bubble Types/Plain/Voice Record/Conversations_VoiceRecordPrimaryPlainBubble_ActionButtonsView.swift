//
//  Conversations_VoiceRecordPrimaryPlainBubble_ActionButtonsView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-03.
//

import SwiftUI

struct Conversations_VoiceRecordPrimaryPlainBubble_ActionButtonsView: View {
    // MARK: - PROPERTIES
    let direction: BubbleShapeValues.Directions
    let actionType: VoiceRecordBubbleValues.ActionTypes
    let action: () -> Void
    
    // MARK: - PRIVATE PROPERTIES
    let values = VoiceRecordBubbleValues.self
    var iconImage: Image {
        switch actionType {
        case .play:
                .init(.play)
        case .pause:
                .init(.pause)
        case .cancel:
                .init(systemName: "xmark")
        case .upload:
                .init(.arrowUpCircle)
        }
    }
    
    var iconFrameWidth: CGFloat {
        switch actionType {
        case .play, .pause:
            values.actionIconsFrameWidth
        case .cancel:
            values.actionIconsFrameWidth - 5
        case .upload:
            values.actionIconsFrameWidth + 10
        }
    }
    
    var rotationDegree: CGFloat {
        actionType == .upload && direction == .left ? 180 : 0
    }
    
    // MARK: - INITILAIZER
    init(
        direction: BubbleShapeValues.Directions,
        actionType: VoiceRecordBubbleValues.ActionTypes,
        action: @escaping () -> Void
    ) {
        self.direction = direction
        self.actionType = actionType
        self.action = action
    }
    
    // MARK: - BODY
    var body: some View {
        iconImage
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: iconFrameWidth)
            .frame(width: values.actionIconsFrameWidth)
            .foregroundStyle(direction == .right ? .micPlaybackNCancelIconsSender : .micPlaybackNCancelIconsReceiver)
            .fontWeight(actionType == .cancel ? .bold : .regular)
            .rotationEffect(.degrees(rotationDegree))
            .padding(direction == .right ? .horizontal : .trailing, values.actionIconsHPadding)
            .padding(.leading, direction == .left ? values.actionIconsHPadding/2 : 0)
            .onTapGesture { action() }
    }
}

#Preview("Conversations_VoiceRecordPrimaryPlainBubble_ActionButtonsView") {
    Conversations_VoiceRecordPrimaryPlainBubble_ActionButtonsView(
        direction: .random(),
        actionType: .random()
    ) {
        print("Clicked!")
    }
    .previewViewModifier
}
