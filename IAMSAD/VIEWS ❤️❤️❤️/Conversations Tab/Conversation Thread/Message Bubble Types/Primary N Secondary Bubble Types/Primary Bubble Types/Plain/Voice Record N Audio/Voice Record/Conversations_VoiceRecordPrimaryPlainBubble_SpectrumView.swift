//
//  Conversations_VoiceRecordPrimaryPlainBubble_SpectrumView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-03.
//

import SwiftUI

struct Conversations_VoiceRecordPrimaryPlainBubble_SpectrumView: View {
    // MARK: - PROPETIES
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var sliderValue: CGFloat
    @Binding var isThumbTouchDown: Bool
    @Binding var thumbSize: CGFloat
    let direction: BubbleShapeValues.Directions
    let spectrumFrameWidth: CGFloat
    let status: ReadReceiptStatusTypes
    let isProcessing: Bool
    let heightsArray: [CGFloat]
    
    // MARK: - INITITIALIZER
    init(
        sliderValue: Binding<CGFloat>,
        isThumbTouchDown: Binding<Bool>,
        thumbSize: Binding<CGFloat>,
        direction: BubbleShapeValues.Directions,
        spectrumFrameWidth: CGFloat,
        status: ReadReceiptStatusTypes,
        isProcessing: Bool = false,
        heightsArray: [CGFloat]
    ) {
        self._sliderValue = sliderValue
        self._isThumbTouchDown = isThumbTouchDown
        self._thumbSize = thumbSize
        self.direction = direction
        self.spectrumFrameWidth = spectrumFrameWidth
        self.status = status
        self.isProcessing = isProcessing
        self.heightsArray = heightsArray
    }
    
    // MARK: - PRIVATE PROPERTIES
    let values = VoiceRecordNAudioBubbleValues.self
    
    var thumbTintColor: UIColor {
        switch direction {
        case .left:
                .appLogoBased
        case .right:
            status == .seen ? .sliderThumbOnSeen : .sliderThumb
        }
    }
    
    // MARK: - BODY
    var body: some View {
        spectrum
            .overlay(alignment: .leading) {
                maskOverlay
                    .mask(alignment: .leading) { spectrum }
            }
            .opacity(isProcessing ? 0 : 1)
            .overlay {
                slider.opacity(isProcessing ? 0 : 1)
                if isProcessing { Conversations_VoiceRecordNAudioPrimaryPlainBubble_HProgressBarView() }
            }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_VoiceRecordPrimaryPlainBubble_SpectrumView") {
    Conversations_VoiceRecordPrimaryPlainBubble_SpectrumView(
        sliderValue: .constant(.random(in: 0...1)),
        isThumbTouchDown: .constant(false),
        thumbSize: .constant(15),
        direction: .random(),
        spectrumFrameWidth: VoiceRecordNAudioBubbleValues.actualSpectrumWidth,
        status: .random(),
        heightsArray: VoiceRecordNAudioBubbleValues.getMockArrayOfHeights()
    )
}

// MARK: - EXTENSIONS
extension Conversations_VoiceRecordPrimaryPlainBubble_SpectrumView {
    // MARK: - spectrum
    private var spectrum: some View {
        HStack(spacing: values.spacingPerSpectrumFrame) {
            ForEach(heightsArray, id: \.self) {
                Capsule()
                    .fill(direction == .right ? .inactiveSpectrumSender : .inactiveSpectrumReceiver)
                    .frame(width: values.widthPerSpectrumFrame, height: $0)
            }
        }
        .frame(width: spectrumFrameWidth, height: values.spectrumMaxHeight)
    }
    
    // MARK: - maskOverlay
    private var maskOverlay: some View {
        Rectangle()
            .fill(direction == .right ? .activeSpectrumSender : .activeSpectrumReceiver)
            .frame(width: maskWidthHandler())
    }
    
    // MARK: - slider
    private var slider: some View {
        CustomSliderView(
            value: $sliderValue,
            isThumbTouchDown: $isThumbTouchDown,
            thumbSize: $thumbSize,
            scale: values.thumbScale,
            thumbTintColor: thumbTintColor,
            minimumTrackTintColor: .clear,
            maximumTrackTintColor: .clear
        )
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - maskWidthHandler
    private func maskWidthHandler() -> CGFloat {
        spectrumFrameWidth * sliderValue
    }
}
