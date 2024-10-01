//
//  Conversations_DocumentAudioPrimaryPlainBubble_ProcessingView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-06.
//

import SwiftUI

struct Conversations_DocumentAudioPrimaryPlainBubble_ProcessingView: View {
    // MARK: - PROPERTIES
    let direction: BubbleShapeValues.Directions
    let progressValue: CGFloat
    let showProgressIcon: Bool
    let showProgressBar: Bool
    let isExist: Bool
    let action: () -> Void
    
    // MARK: - INITILAIZER
    init(
        direction: BubbleShapeValues.Directions,
        progressValue: CGFloat,
        showProgressIcon: Bool,
        showProgressBar: Bool,
        isExist: Bool,
        action: @escaping () -> Void
    ) {
        self.direction = direction
        self.progressValue = progressValue
        self.showProgressIcon = showProgressIcon
        self.showProgressBar = showProgressBar
        self.isExist = isExist
        self.action = action
    }
    
    // MARK: - PRIVATE PROPERTIES
    let values = VoiceRecordNAudioBubbleValues.self
    let strokeWidth: CGFloat = 1.6
    var padding: CGFloat { strokeWidth/2 }
    var color: Color { direction == .left ? .appLogoBased : .progressIndicators }
    
    // MARK: - BODY
    var body: some View {
        if !isExist {
            Image(.arrowUpCircle)
                .renderingMode(.template)
                .foregroundStyle(color)
                .rotationEffect(.degrees(direction == .left ? 180 : 0))
                .opacity(showProgressIcon ? 1 : 0)
                .overlay { overlayContent }
                .padding(.leading, values.actionIconsHPadding)
                .padding(.trailing, values.actionIconsHPadding/2)
                .animation(.smooth, value: [showProgressIcon, showProgressBar])
                .onTapGesture { action() }
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_DocumentAudioPrimaryPlainBubble_ProcessingView") {
    BubbleVariator_Preview {
        Conversations_DocumentAudioPrimaryPlainBubble_ProcessingView(
            direction: .random(),
            progressValue: 0,
            showProgressIcon: $0,
            showProgressBar: !$0,
            isExist: false) { print("Tapped") }
    }
}

// MARK: - EXTENSIONS
extension Conversations_DocumentAudioPrimaryPlainBubble_ProcessingView {
    // MARK: - overlayContent
    private var overlayContent: some View {
        CustomCircularProgressBarView(
            value: progressValue,
            circleStrokeColor: color.opacity(0.1),
            progressStrokeColor: color,
            strokeWidth: strokeWidth,
            stopRectangleColor: color,
            stopRectanglePadding: 7.5,
            cornerRadius: 1
        )
        .opacity(showProgressBar ? 1 : 0)
        .padding(padding)
    }
}
