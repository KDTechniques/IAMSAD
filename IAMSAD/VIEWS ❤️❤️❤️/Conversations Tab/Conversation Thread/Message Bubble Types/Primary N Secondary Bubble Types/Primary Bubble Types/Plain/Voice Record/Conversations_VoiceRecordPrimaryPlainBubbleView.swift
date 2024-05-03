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
    
    let imageURLString: String = ""
    let voiceRecordURLString: String = ""
    let status: ReadReceiptStatusTypes = .delivered
    let shouldAnimate: Bool = false
    let duration: String = "0:05"
    let timestamp: String = "12:30 AM"
    let values = MessageBubbleValues.self
    let voiceRecordValues = VoiceRecordBubbleValues.self
    
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
    
    @State private var sliderValue: CGFloat = 0
    @State private var isThumbTouchDown: Bool = false
    @State private var thumbSize: CGFloat = 0
    @State private var fileSize: String = "23 KB"
    @State private var isActive: Bool = true
    @State private var isUploading: Bool = false
    
    // MARK: - BODY
    var body: some View {
        Conversations_MessageBubbleView(
            direction: .right,
            showPointer: true
        ) {
            HStack {
                if !isActive {
                    Conversations_VoiceRecordPrimaryPlainBubble_ImageView(urlString: imageURLString)
                }
                
                HStack(alignment: .top) {
                    HStack {
                        if isActive {
                            Conversations_VoiceRecordPrimaryPlainBubble_PlaybackSpeedCapsuleView { }
                        }
                        
                        Conversations_VoiceRecordPrimaryPlainBubble_ActionButtonsView(actionType: .play) { }
                    }
                    .frame(height: voiceRecordValues.spectrumMaxHeight)
                    
                    VStack(spacing: 7) {
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
                            status: .seen,
                            shouldAnimate: false
                        )
                    }
                }
            }
            .padding(.horizontal, values.innerHPadding)
            .padding(.vertical, values.innerVPadding)
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_VoiceRecordPrimaryPlainBubbleView") {
    Conversations_VoiceRecordPrimaryPlainBubbleView()
        .previewViewModifier
}
