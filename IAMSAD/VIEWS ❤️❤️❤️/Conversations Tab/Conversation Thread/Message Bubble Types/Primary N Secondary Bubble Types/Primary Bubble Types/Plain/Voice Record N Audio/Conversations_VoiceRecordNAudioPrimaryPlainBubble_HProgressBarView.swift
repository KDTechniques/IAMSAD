//
//  Conversations_VoiceRecordNAudioPrimaryPlainBubble_HProgressBarView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-09.
//

import SwiftUI

struct Conversations_VoiceRecordNAudioPrimaryPlainBubble_HProgressBarView: View {
    // MARK: - PROPERTIES
    let progressBarHeight: CGFloat = 4
    var progressIndicatorHeight: CGFloat { progressBarHeight + 1 }
    let progressIndicatorWidth: CGFloat = 18
    let progressBarAnimation: Animation = .linear(duration: 5).repeatForever(autoreverses: false)
    
    @State private var alignment: Alignment = .bottomLeading
    
    // MARK: - INITITALIER
    
    
    // MARK: - BODY
    var body: some View {
        progressBar
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_VoiceRecordNAudioPrimaryPlainBubble_HProgressBarView") {
    Conversations_VoiceRecordNAudioPrimaryPlainBubble_HProgressBarView()
        .padding(.horizontal)
}

// MARK: - EXTENSIONS
extension Conversations_VoiceRecordNAudioPrimaryPlainBubble_HProgressBarView {
    // MARK: - progressIndicator
    private var progressIndicator: some View {
        Rectangle()
            .fill(.progressIndicators)
            .frame(width: progressIndicatorWidth, height: progressIndicatorHeight)
    }
    
    // MARK: - progressBar
    private var progressBar: some View {
        Capsule()
            .fill(.sliderTrack)
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
