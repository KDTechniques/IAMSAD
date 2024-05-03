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
    let spectrumFrameWidth: CGFloat
    let status: ReadReceiptStatusTypes
    let isActive: Bool
    let isUploading: Bool
    let heightsArray: [CGFloat]
    
    // MARK: - INITITIALIZER
    init(
        sliderValue: Binding<CGFloat>,
        isThumbTouchDown: Binding<Bool>,
        thumbSize: Binding<CGFloat>,
        spectrumFrameWidth: CGFloat,
        status: ReadReceiptStatusTypes,
        isActive: Bool,
        isUploading: Bool = false,
        heightsArray: [CGFloat]
    ) {
        self._sliderValue = sliderValue
        self._isThumbTouchDown = isThumbTouchDown
        self._thumbSize = thumbSize
        self.spectrumFrameWidth = spectrumFrameWidth
        self.status = status
        self.isActive = isActive
        self.isUploading = isUploading
        self.heightsArray = heightsArray
    }
    
    // MARK: - PRIVATE PROPERTIES
    let values = VoiceRecordBubbleValues.self
    let thumbScale: CGFloat = 0.45
    let progressBarHeight: CGFloat = 4
    var progressIndicatorHeight: CGFloat { progressBarHeight + 1 }
    let progressIndicatorWidth: CGFloat = 18
    let progressBarAnimation: Animation = .linear(duration: 5).repeatForever(autoreverses: false)
    
    var spectrumColor: Color {
        isActive
        ? .activeSpectrum
        : .primary.opacity(colorScheme == .dark ? 0.3 : 0.19)
    }
    
    @State private var alignment: Alignment = .bottomLeading
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: values.spacingPerSpectrumFrame) {
            ForEach(heightsArray, id: \.self) {
                Capsule()
                    .fill(spectrumColor)
                    .frame(width: values.widthPerSpectrumFrame, height: $0)
            }
        }
        .frame(width: spectrumFrameWidth, height: values.spectrumMaxHeight)
        .overlay {
            if !isUploading {
                slider
            } else {
                progressBar
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_VoiceRecordPrimaryPlainBubble_SpectrumView") {
    Conversations_VoiceRecordPrimaryPlainBubble_SpectrumView(
        sliderValue: .constant(0),
        isThumbTouchDown: .constant(false),
        thumbSize: .constant(15),
        spectrumFrameWidth: 150,
        status: .seen,
        isActive: false,
        heightsArray: VoiceRecordBubbleValues.getMockArrayOfHeights()
    )
}

// MARK: - EXTENSIONS
extension Conversations_VoiceRecordPrimaryPlainBubble_SpectrumView {
    // MARK: -
    
    // MARK: - slider
    private var slider: some View {
        CustomSliderView(
            value: $sliderValue,
            isThumbTouchDown: $isThumbTouchDown,
            thumbSize: $thumbSize,
            scale: thumbScale,
            thumbTintColor: status == .seen ? .sliderThumbOnSeen : .sliderThumb,
            minimumTrackTintColor: .clear,
            maximumTrackTintColor: .clear
        )
    }
    
    // MARK: - progressIndicator
    private var progressIndicator: some View {
        Rectangle()
            .fill(.rectangleProgressIndicator)
            .frame(width: progressIndicatorWidth, height: progressIndicatorHeight)
    }
    
    // MARK: - progressBar
    private var progressBar: some View {
        Capsule()
            .fill(.black.opacity(0.1))
            .frame(height: progressBarHeight)
            .overlay(alignment: alignment) { progressIndicator }
            .animation(progressBarAnimation, value: alignment)
            .onAppear { onProgressBarAppear() }
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - onProgressBarAppear
    private func onProgressBarAppear() {
        alignment = .bottomTrailing
    }
}
