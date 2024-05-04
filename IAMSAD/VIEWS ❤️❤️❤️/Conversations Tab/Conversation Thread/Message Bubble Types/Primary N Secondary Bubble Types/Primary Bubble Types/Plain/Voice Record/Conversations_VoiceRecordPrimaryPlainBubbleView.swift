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
    
    let imageURLString: String = "https://dynl.mktgcdn.com/p/fZYVExInA1kabvL66aVysERPQERyVk8ibBQoTCEMWfY/500x500"
    let voiceRecordURLString: String = ""
    let status: ReadReceiptStatusTypes = .seen
    let shouldAnimate: Bool = false
    let duration: String = "0:05"
    let timestamp: String = "12:30 AM"
    let values = MessageBubbleValues.self
    let voiceRecordValues = VoiceRecordBubbleValues.self
    let extraHPadding: CGFloat = 10
    
    var actualSpectrumWidth: CGFloat {
        let value1: CGFloat = CGFloat(voiceRecordValues.framesCount) *
        voiceRecordValues.widthPerSpectrumFrame
        
        let value2: CGFloat = CGFloat((voiceRecordValues.framesCount-1)) *
        voiceRecordValues.spacingPerSpectrumFrame
        
        return value1 + value2
    }
    
    var thumbAlignedSpectrumWidth: CGFloat {
        actualSpectrumWidth +
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
    @State private var fileSize: String = "23 KB"
    @State private var isActive: Bool = false
    @State private var isUploading: Bool = false
    
    // MARK: - BODY
    var body: some View {
        Conversations_MessageBubbleView(
            direction: .right,
            showPointer: true
        ) {
            HStack(spacing: 0) {
                if !isActive {
                    Conversations_VoiceRecordPrimaryPlainBubble_ImageView(urlString: imageURLString)
                        .offset(x: -voiceRecordValues.strokedMicImageWidth/3)
                }
                
                HStack(alignment: .top, spacing: 0) {
                    HStack(spacing: 0) {
                        if isActive {
                            Conversations_VoiceRecordPrimaryPlainBubble_PlaybackSpeedCapsuleView { }
                        }
                        
                        Conversations_VoiceRecordPrimaryPlainBubble_ActionButtonsView(actionType: .play) { }
                            .padding(.horizontal, voiceRecordValues.actionIconsHPadding)
                    }
                    .frame(height: voiceRecordValues.spectrumMaxHeight)
                    
                    VStack(spacing: vContainerSpacing) {
                        Conversations_VoiceRecordPrimaryPlainBubble_SpectrumView(
                            sliderValue: $sliderValue,
                            isThumbTouchDown: $isThumbTouchDown,
                            thumbSize: $thumbSize,
                            spectrumFrameWidth: thumbAlignedSpectrumWidth,
                            status: status,
                            isActive: isActive,
                            isUploading: isUploading,
                            heightsArray: voiceRecordValues.getMockArrayOfHeights()
                        )
                        
                        Conversations_VoiceRecordPrimaryPlainBubble_BottomTrailingView(
                            width: thumbAlignedSpectrumWidth,
                            fileSize: "43 KB",
                            duration: "1:45",
                            type: .duration,
                            timestamp: "05:36 AM",
                            status: status,
                            shouldAnimate: false
                        )
                    }
                }
                .padding(.top, extraHPadding)
            }
            .messageBubbleContentDefaultPadding
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_VoiceRecordPrimaryPlainBubbleView") {
    Conversations_VoiceRecordPrimaryPlainBubbleView()
        .previewViewModifier
}
