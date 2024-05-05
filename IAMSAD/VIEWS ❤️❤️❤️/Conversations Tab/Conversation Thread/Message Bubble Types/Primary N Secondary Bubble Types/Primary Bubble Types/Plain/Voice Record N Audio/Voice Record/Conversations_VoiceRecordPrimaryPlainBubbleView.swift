//
//  Conversations_VoiceRecordPrimaryPlainBubbleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-01.
//

import SwiftUI
import SDWebImageSwiftUI

struct Conversations_VoiceRecordPrimaryPlainBubbleView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    let direction: BubbleShapeValues.Directions
    let showPointer: Bool
    let imageURLString: String
    let voiceRecordURLString: String
    let status: ReadReceiptStatusTypes
    let shouldAnimate: Bool
    let timestamp: String
    
    // MARK: - INITIALIZER
    init(
        direction: BubbleShapeValues.Directions,
        showPointer: Bool,
        imageURLString: String,
        voiceRecordURLString: String,
        status: ReadReceiptStatusTypes,
        shouldAnimate: Bool,
        timestamp: String
    ) {
        self.direction = direction
        self.showPointer = showPointer
        self.imageURLString = imageURLString
        self.voiceRecordURLString = voiceRecordURLString
        self.status = status
        self.shouldAnimate = shouldAnimate
        self.timestamp = timestamp
    }
    
    // MARK: - PRIVATE PROPERTIES
    let values = MessageBubbleValues.self
    let voiceRecordValues = VoiceRecordBubbleValues.self
    let extraHPadding: CGFloat = 10
    
    var thumbAlignedSpectrumWidth: CGFloat {
        voiceRecordValues.actualSpectrumWidth +
        (thumbSize/2) +
        (voiceRecordValues.widthPerSpectrumFrame/2)
    }
    
    var vContainerSpacing: CGFloat {
        extraHPadding -
        abs(values.bottomTrailingContentBottomPadding)
    }
    
    @State private var sliderValue: CGFloat = 0
    @State private var isThumbTouchDown: Bool = false
    @State private var thumbSize: CGFloat = 0
    @State private var isActive: Bool = false
    @State private var isProcessing: Bool = false
    @State private var action: VoiceRecordBubbleValues.ActionTypes = .process
    @State private var heightsArray: [CGFloat] = VoiceRecordBubbleValues.getMockArrayOfHeights()
    @State private var duration: String = "0:00"
    @State private var fileSize: String = "0 KB"
    
    // MARK: - BODY
    var body: some View {
        Conversations_MessageBubbleView(
            direction: direction,
            showPointer: showPointer
        ) {
            HStack(spacing: 0) {
                if !isActive, direction == .right {
                    Conversations_VoiceRecordPrimaryPlainBubble_ImageView(urlString: imageURLString, direction: direction)
                }
                
                HStack(alignment: .top, spacing: 0) {
                    HStack(spacing: 0) {
                        if isActive, direction == .right {
                            Conversations_VoiceRecordPrimaryPlainBubble_PlaybackSpeedCapsuleView(direction: direction) { }
                        }
                        
                        Conversations_VoiceRecordNAudioPrimaryPlainBubble_ActionButtonsView(
                            direction: direction,
                            actionType: action
                        ) { }
                    }
                    .frame(height: voiceRecordValues.spectrumMaxHeight)
                    
                    VStack(spacing: vContainerSpacing) {
                        spectrum
                        bottomContent
                    }
                    .padding(.trailing, direction == .right ? 0 : voiceRecordValues.actionIconsHPadding/2)
                    
                    if isActive, direction == .left {
                        Conversations_VoiceRecordPrimaryPlainBubble_PlaybackSpeedCapsuleView(direction: direction) { }
                    }
                }
                .padding(.top, extraHPadding)
                
                if !isActive, direction == .left {
                    Conversations_VoiceRecordPrimaryPlainBubble_ImageView(urlString: imageURLString, direction: direction)
                }
            }
            .messageBubbleContentDefaultPadding
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_VoiceRecordPrimaryPlainBubbleView") {
    ZStack {
        Color.conversationBackground
        
        Conversations_VoiceRecordPrimaryPlainBubbleView(
            direction: .random(),
            showPointer: .random(),
            imageURLString: "https://www.akc.org/wp-content/uploads/2018/08/nervous_lab_puppy-studio-portrait-lg-500x500.jpg",
            voiceRecordURLString: "",
            status: .random(),
            shouldAnimate: .random(),
            timestamp: "05:48 PM"
        )
    }
    .ignoresSafeArea()
    .previewViewModifier
}

// MARK: - EXTENSIONS
extension Conversations_VoiceRecordPrimaryPlainBubbleView {
    // MARK: - spectrum
    private var spectrum: some View {
        Conversations_VoiceRecordPrimaryPlainBubble_SpectrumView(
            sliderValue: $sliderValue,
            isThumbTouchDown: $isThumbTouchDown,
            thumbSize: $thumbSize,
            direction: direction,
            spectrumFrameWidth: thumbAlignedSpectrumWidth,
            status: status,
            isProcessing: isProcessing,
            heightsArray: heightsArray
        )
    }
    
    // MARK: - bottomContent
    private var bottomContent: some View {
        Conversations_VoiceRecordNAudioPrimaryPlainBubble_BottomTrailingView(
            width: thumbAlignedSpectrumWidth,
            fileSize: fileSize,
            duration: duration,
            type: isProcessing ? .fileSize : .duration,
            timestamp: timestamp,
            status: status,
            shouldAnimate: shouldAnimate
        )
    }
}
