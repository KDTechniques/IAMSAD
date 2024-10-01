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
    
    let direction: BubbleShapeValues.Directions
    let action: () -> Void
    
    // MARK: INITILAIZER
    init(direction: BubbleShapeValues.Directions, action: @escaping () -> Void) {
        self.direction = direction
        self.action = action
    }
    
    // MARK: - PRIVATE PROPERTIES
    let values = VoiceRecordNAudioBubbleValues.self
    var capsuleWidth: CGFloat { values.imageSize - 2 }
    var capsuleHeight: CGFloat { values.actionIconsFrameWidth + 8 }
    let font: Font = .caption
    let speedsArray: [VoiceRecordNAudioBubbleValues.PlaybackSpeedTypes] = Array(VoiceRecordNAudioBubbleValues.PlaybackSpeedTypes.allCases)
    
    @State private var currentPlaybackSpeed: VoiceRecordNAudioBubbleValues.PlaybackSpeedTypes = ._1x
    
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
    BubbleVariator_Preview {
        Conversations_VoiceRecordPrimaryPlainBubble_PlaybackSpeedCapsuleView(direction: $0 ? .left : .right) {
            print("Clicked on Capsule!")
        }
    }
    .previewViewModifier
}

// MARK: - EXTENSIONS
extension Conversations_VoiceRecordPrimaryPlainBubble_PlaybackSpeedCapsuleView {
    // MARK: - capsule
    private var capsule: some View {
        Capsule()
            .fill(direction == .right ? .voiceRecordPlaybackSpeedCapsuleSender : .voiceRecordPlaybackSpeedCapsuleReceiver)
            .frame(width: capsuleWidth, height: capsuleHeight)
            .frame(width: values.imageSize, alignment: direction == .right ? .trailing : .leading)
    }
    
    // MARK: - text
    private var text: some View {
        Text(currentPlaybackSpeed.rawValue)
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
        
        currentPlaybackSpeed = index < speedsArray.count-1 ? speedsArray[index+1] : ._1x
        action()
    }
}
