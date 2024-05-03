//
//  Conversations_VoiceRecordPrimaryPlainBubble_PlaybackSpeedCapsuleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-03.
//

import SwiftUI

struct Conversations_VoiceRecordPrimaryPlainBubble_PlaybackSpeedCapsuleView: View {
    // MARK: - PROPERTIES
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    let action: () -> Void
    
    // MARK: INITILAIZER
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    // MARK: - PRIVATE PROPERTIES
    let values = VoiceRecordBubbleValues.self
    var capsuleHeight: CGFloat { values.playPauseIconsWidth + 8 }
    let font: Font = .caption
    let speedsArray: [VoiceRecordBubbleValues.PlaybackSpeedTypes] = Array(VoiceRecordBubbleValues.PlaybackSpeedTypes.allCases)
    
    @State private var currentPlaybackSpeed: VoiceRecordBubbleValues.PlaybackSpeedTypes = ._1x
    
    // MARK: - BODY
    var body: some View {
        capsule
            .overlay {
                HStack(spacing: 1) {
                    text
                    xmark
                }
                .foregroundStyle(.white)
            }
            .onTapGesture { toggleSpeed() }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_VoiceRecordPrimaryPlainBubble_PlaybackSpeedCapsuleView") {
    Conversations_VoiceRecordPrimaryPlainBubble_PlaybackSpeedCapsuleView {
        print("Clicked on Capsule!")
    }
    .previewViewModifier
}

// MARK: - EXTENSIONS
extension Conversations_VoiceRecordPrimaryPlainBubble_PlaybackSpeedCapsuleView {
    // MARK: - capsule
    private var capsule: some View {
        Capsule()
            .fill(.voiceRecordPlaybackSpeedCapsule)
            .frame(width: values.imageSize, height: capsuleHeight)
    }
    
    // MARK: - text
    private var text: some View {
        Text("1.5")
            .font(font.weight(.semibold))
    }
    
    // MARK: - xmark
    @ViewBuilder
    private var xmark: some View {
        let xmarkSize: CGFloat = "".heightOfHString(usingFont: .from(font), dynamicTypeSize) - 7
        
        Image(systemName: "xmark")
            .resizable()
            .scaledToFit()
            .frame(width: xmarkSize, height: xmarkSize)
            .fontWeight(.heavy)
            .offset(y: 0.5)
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - toggleSpeed
    private func toggleSpeed() {
        guard let index: Int = speedsArray.firstIndex(of: currentPlaybackSpeed) else { return }
        
        currentPlaybackSpeed = index < speedsArray.endIndex ? speedsArray[index+1] : ._1x
        action()
    }
}
