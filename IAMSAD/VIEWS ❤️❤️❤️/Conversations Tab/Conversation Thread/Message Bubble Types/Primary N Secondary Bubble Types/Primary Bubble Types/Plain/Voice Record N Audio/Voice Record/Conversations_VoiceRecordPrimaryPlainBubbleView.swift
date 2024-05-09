//
//  Conversations_VoiceRecordPrimaryPlainBubbleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-01.
//

import SwiftUI
import SDWebImageSwiftUI
import CoreMedia

struct Conversations_VoiceRecordPrimaryPlainBubbleView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    let model: MessageBubbleValues.MessageBubbleModel
    let imageURLString: String
    let voiceRecordURLString: String
    let fileData: VoiceRecordNAudioBubbleValues.FileDataModel
    
    // MARK: - INITIALIZER
    init(
        model: MessageBubbleValues.MessageBubbleModel,
        imageURLString: String,
        voiceRecordURLString: String,
        fileData: VoiceRecordNAudioBubbleValues.FileDataModel
    ) {
        self.model = model
        self.imageURLString = imageURLString
        self.voiceRecordURLString = voiceRecordURLString
        self.fileData = fileData
    }
    
    // MARK: - PRIVATE PROPERTIES
    let values = MessageBubbleValues.self
    let voiceRecordValues = VoiceRecordNAudioBubbleValues.self
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
    @State private var action: VoiceRecordNAudioBubbleValues.ActionTypes = .process
    @State private var heightsArray: [CGFloat] = VoiceRecordNAudioBubbleValues.getMockArrayOfHeights()
    
    // MARK: - BODY
    var body: some View {
        Conversations_MessageBubbleView(model) {
            HStack(spacing: 0) {
                if model.direction == .right { image(model.direction) }
                
                HStack(alignment: .top, spacing: 0) {
                    HStack(spacing: 0) {
                        if model.direction == .right {
                            playbackSpeedCapsule(model.direction) {
                                // action goes here...
                            }
                        }
                        
                        Conversations_VoiceRecordNAudioPrimaryPlainBubble_ActionButtonsView(
                            direction: model.direction,
                            actionType: action
                        ) { }
                    }
                    .frame(height: voiceRecordValues.spectrumMaxHeight)
                    
                    vContainer
                    
                    playbackSpeedCapsule(model.direction) {
                        // action goes here...
                    }
                }
                .padding(.top, extraHPadding)
                
                if model.direction == .left { image(model.direction) }
            }
            .messageBubbleContentDefaultPadding
            .forwardedPaddingViewModifier(model.isForwarded, fraction: 1)
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_VoiceRecordPrimaryPlainBubbleView") {
    ZStack {
        Color.conversationBackground
        
        Conversations_VoiceRecordPrimaryPlainBubbleView(
            model: .getRandomMockObject(true),
            imageURLString: "https://www.akc.org/wp-content/uploads/2018/08/nervous_lab_puppy-studio-portrait-lg-500x500.jpg",
            voiceRecordURLString: "",
            fileData: .init(
                fileURLString: "",
                fileName: "",
                fileSize: "25 KB",
                fileExtension: "",
                duration: .zero
            )
        )
    }
    .ignoresSafeArea()
    .previewViewModifier
}

// MARK: - EXTENSIONS
extension Conversations_VoiceRecordPrimaryPlainBubbleView {
    // MARK: - image
    @ViewBuilder
    private func image(_ direction: BubbleShapeValues.Directions) -> some View {
        if !isActive {
            Conversations_VoiceRecordPrimaryPlainBubble_ImageView(urlString: imageURLString, direction: direction)
        }
    }
    
    // MARK: - playbackSpeedCapsule
    @ViewBuilder
    private func playbackSpeedCapsule(
        _ direction: BubbleShapeValues.Directions,
        action: @escaping () -> Void
    ) -> some View {
        if isActive {
            Conversations_VoiceRecordPrimaryPlainBubble_PlaybackSpeedCapsuleView(direction: direction) {
                action()
            }
        }
    }
    
    // MARK: - spectrum
    private var spectrum: some View {
        Conversations_VoiceRecordPrimaryPlainBubble_SpectrumView(
            sliderValue: $sliderValue,
            isThumbTouchDown: $isThumbTouchDown,
            thumbSize: $thumbSize,
            direction: model.direction,
            spectrumFrameWidth: thumbAlignedSpectrumWidth,
            status: model.status,
            isProcessing: isProcessing,
            heightsArray: heightsArray
        )
    }
    
    // MARK: - bottomContent
    private var bottomContent: some View {
        Conversations_VoiceRecordNAudioPrimaryPlainBubble_BottomTrailingView(
            model: model,
            width: thumbAlignedSpectrumWidth,
            fileSize: fileData.fileSize,
            duration: fileData.duration,
            type: isProcessing ? .fileSize : .duration
        )
    }
    
    // MARK: - vContainer
    private var vContainer: some View {
        VStack(spacing: vContainerSpacing) {
            spectrum
            bottomContent
        }
        .padding(.trailing, model.direction == .right ? 0 : voiceRecordValues.actionIconsHPadding/2)
    }
}
