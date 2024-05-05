//
//  Conversations_SharedAudioPrimaryPlainBubbleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-01.
//

import SwiftUI
import SDWebImageSwiftUI

struct Conversations_SharedAudioPrimaryPlainBubbleView: View {
    
    // MARK: - PROPERTIES
    let direction: BubbleShapeValues.Directions
    let showPointer: Bool
    let timestamp: String
    let status: ReadReceiptStatusTypes
    let shouldAnimate: Bool
    
    // MARK: - INITITILAZER
    init(
        direction: BubbleShapeValues.Directions,
        showPointer: Bool,
        timestamp: String,
        status: ReadReceiptStatusTypes,
        shouldAnimate: Bool
    ) {
        self.direction = direction
        self.showPointer = showPointer
        self.timestamp = timestamp
        self.status = status
        self.shouldAnimate = shouldAnimate
    }
    
    // MARK: - PRIVATE PROPERTIES
    let values = VoiceRecordBubbleValues.self
    
    @State private var sliderValue: CGFloat = 0
    @State private var isProcessing: Bool = false
    @State private var action: VoiceRecordBubbleValues.ActionTypes = .process
    @State private var duration: String = "0:00"
    @State private var fileSize: String = "0 KB"
    
    // MARK: - BODY
    var body: some View {
        Conversations_MessageBubbleView(direction: direction, showPointer: showPointer) {
            HStack(spacing: 0) {
                if direction == .right {
                    Conversations_SharedAudioPrimaryPlainBubble_ImageView(direction: direction)
                }
                
                Conversations_VoiceRecordNAudioPrimaryPlainBubble_ActionButtonsView(
                    direction: direction,
                    actionType: action) { }
                
                slider
                    .background { sliderTrack }
                    .overlay(alignment: .bottom) { bottomContent }
                    .padding(.trailing, direction == .left ? values.actionIconsHPadding/2 : 0)
                
                if direction == .left {
                    Conversations_SharedAudioPrimaryPlainBubble_ImageView(direction: direction)
                }
            }
            .messageBubbleContentDefaultPadding
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_SharedAudioPrimaryPlainBubbleView") {
    ZStack {
        Color.conversationBackground
            .ignoresSafeArea()
        
        Conversations_SharedAudioPrimaryPlainBubbleView(
            direction: .random(),
            showPointer: .random(),
            timestamp: "12:16 AM",
            status: .random(),
            shouldAnimate: .random()
        )
    }
    .previewViewModifier
}

// MARK: - EXTENTIONS
extension Conversations_SharedAudioPrimaryPlainBubbleView {
    // MARK: - slider
    private var slider: some View {
        CustomSliderView(
            value: $sliderValue,
            scale: values.thumbScale,
            thumbTintColor: .sliderThumbOnSeen,
            minimumTrackTintColor: .clear,
            maximumTrackTintColor: .clear
        )
        .frame(height: values.imageSize)
    }
    
    // MARK - sliderTrack
    private var sliderTrack: some View {
        Capsule()
            .fill(.sliderTrack)
            .frame(height: 4)
    }
    
    // MARK: - bottomContent
    private var bottomContent: some View {
        Conversations_VoiceRecordNAudioPrimaryPlainBubble_BottomTrailingView(
            fileSize: fileSize,
            duration: duration,
            type: isProcessing ? .fileSize : .duration,
            timestamp: timestamp,
            status: status,
            shouldAnimate: shouldAnimate
        )
    }
}
