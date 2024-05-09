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
    let model: MessageBubbleValues.MessageBubbleModel
    let fileData: VoiceRecordNAudioBubbleValues.FileDataModel
    
    // MARK: - INITITILAZER
    init(
        model: MessageBubbleValues.MessageBubbleModel,
        fileData: VoiceRecordNAudioBubbleValues.FileDataModel
    ) {
        self.model = model
        self.fileData = fileData
    }
    
    // MARK: - PRIVATE PROPERTIES
    let values = VoiceRecordNAudioBubbleValues.self
    
    @State private var sliderValue: CGFloat = 0
    @State private var isProcessing: Bool = false
    @State private var action: VoiceRecordNAudioBubbleValues.ActionTypes = .process
    
    // MARK: - BODY
    var body: some View {
        Conversations_MessageBubbleView(model) {
            HStack(spacing: 0) {
                if model.direction == .right {
                    Conversations_SharedAudioPrimaryPlainBubble_ImageView(direction: model.direction)
                }
                
                Conversations_VoiceRecordNAudioPrimaryPlainBubble_ActionButtonsView(
                    direction: model.direction,
                    actionType: action) { }
                
                Group {
                    if isProcessing {
                        Conversations_VoiceRecordNAudioPrimaryPlainBubble_HProgressBarView()
                    } else {
                        slider
                            .background { sliderTrack }
                    }
                }
                .frame(height: values.imageSize)
                .overlay(alignment: .bottom) { bottomContent }
                .padding(.trailing, model.direction == .left ? values.actionIconsHPadding/2 : 0)
                
                if model.direction == .left {
                    Conversations_SharedAudioPrimaryPlainBubble_ImageView(direction: model.direction)
                }
            }
            .messageBubbleContentDefaultPadding
            .forwardedPaddingViewModifier(model.isForwarded)
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_SharedAudioPrimaryPlainBubbleView") {
    ZStack {
        Color.conversationBackground
            .ignoresSafeArea()
        
        Conversations_SharedAudioPrimaryPlainBubbleView(
            model: .getRandomMockObject(true),
            fileData: .init(
                fileURLString: "",
                fileName: "",
                fileSize: "16 KB",
                fileExtension: "",
                duration: .zero
            )
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
            model: model,
            fileSize: fileData.fileSize,
            duration: fileData.duration,
            type: isProcessing ? .fileSize : .duration
        )
    }
}
