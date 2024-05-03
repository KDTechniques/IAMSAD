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
    
    let status: ReadReceiptStatusTypes = .delivered
    let shouldAnimate: Bool = false
    let duration: String = "0:05"
    let timestamp: String = "12:30 AM"
    let width: CGFloat = 160
    let values = MessageBubbleValues.self
    let widthPerFrame: CGFloat = 2.5 // ✅
    let maxHeightPerFrame: CGFloat = 24 // ✅
    let spacingPerFrame: CGFloat = 1.8 // ✅
    let thumbScale: CGFloat = 0.45 // ✅
    let progressBarAnimation: Animation = .linear(duration: 5).repeatForever(autoreverses: false)
    let imageSize: CGFloat = 45
    let progressBarHeight: CGFloat = 4
    var progressIndicatorHeight: CGFloat { progressBarHeight + 1 }
    let progressIndicatorWidth: CGFloat = 18
    let playPauseIconWidth: CGFloat = 15
    var playbackSpeedCapsuleHeight: CGFloat { playPauseIconWidth + 8 }
    
    var framesCount: Int {
        Int(width/(widthPerFrame+spacingPerFrame))
    }
    
    var reductionValue: CGFloat {
        (maxHeightPerFrame - widthPerFrame) / CGFloat(framesCount)
    }
    
    var randomHeight: CGFloat {
        maxHeightPerFrame - (reductionValue * CGFloat.random(in: 1...CGFloat(framesCount)))
    }
    
    var spectrumWidth: CGFloat {
        let calculation1: CGFloat = CGFloat(framesCount) * widthPerFrame
        let calculation2: CGFloat = CGFloat((framesCount-1)) * spacingPerFrame
        
        return calculation1 + calculation2
    }
    
    var thumbAlignmentSpectrumWidth: CGFloat {
        spectrumWidth + (thumbSize/2) + (widthPerFrame/2)
    }
    
    var spectrumColor: Color {
        bubbleStatus == .active
        ? .activeSpectrum
        : .primary.opacity(colorScheme == .dark ? 0.3 : 0.19)
    }
    
    @State private var sliderValue: CGFloat = 0
    @State private var isThumbTouchDown: Bool = false
    @State private var thumbSize: CGFloat = 0
    @State private var alignment: Alignment = .bottomLeading
    @State private var bubbleStatus: VoiceRecordBubbleStatusTypes = .inactive
    @State private var fileSize: String = "23 KB"
    @State private var test: CGFloat = 0
    
    // MARK: - BODY
    var body: some View {
        Conversations_MessageBubbleView(
            direction: .right,
            showPointer: true
        ) {
            HStack {
                image
                    .padding(.trailing, 12)
                
                HStack(alignment: .top) {
                    HStack {
                        switch bubbleStatus {
                        case .paused, .active:
                            Capsule()
                                .fill(.voiceRecordPlaybackSpeedCapsule)
                                .frame(width: imageSize, height: playbackSpeedCapsuleHeight)
                                .overlay {
                                    HStack(spacing: 1) {
                                        Text("1.5")
                                            .font(.caption.weight(.semibold))
                                        
                                        var xmarkSize: CGFloat {
                                            "".heightOfHString(
                                                usingFont: .from(.caption),
                                                dynamicTypeSize) - 7
                                        }
                                        
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: xmarkSize, height: xmarkSize)
                                            .fontWeight(.heavy)
                                            .offset(y: 0.5)
                                    }
                                    .foregroundStyle(.white)
                                    
                                }
                        default:
                            EmptyView()
                        }
                        
                        switch bubbleStatus {
                        case .paused, .active, .inactive:
                            Image(systemName: bubbleStatus == .paused ? "pause.fill" : "play.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: playPauseIconWidth)
                                .foregroundStyle(.micPlaybackNCancelIcons)
                                .onTapGesture {
                                    // playback action goes here...
                                }
                        default:
                            EmptyView()
                        }
                    }
                    .frame(height: maxHeightPerFrame)
                    
                    vContainer
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

// MARK: - EXTENSIONS
extension Conversations_VoiceRecordPrimaryPlainBubbleView {
    // MARK: - spectrumFrame
    private var spectrumFrame: some View {
        Color.clear
            .frame(width: thumbAlignmentSpectrumWidth, height: maxHeightPerFrame)
    }
    
    // MARK: - spectrum
    private var spectrum: some View {
        HStack(spacing: spacingPerFrame) {
            ForEach(1...framesCount, id: \.self) { index in
                Capsule()
                    .fill(spectrumColor)
                    .frame(width: widthPerFrame, height: randomHeight)
            }
        }
        .frame(width: thumbAlignmentSpectrumWidth)
    }
    
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
    
    // MARK: - progressBar
    private var progressBar: some View {
        Capsule()
            .fill(.black.opacity(0.1))
            .frame(height: progressBarHeight)
            .overlay(alignment: alignment) { progressIndicator }
            .animation(progressBarAnimation, value: alignment)
            .onAppear { onProgressBarAppear() }
    }
    
    // MARK: - progressIndicator
    private var progressIndicator: some View {
        Rectangle()
            .fill(.rectangleProgressIndicator)
            .frame(width: progressIndicatorWidth, height: progressIndicatorHeight)
    }
    
    // MARK: - bottomContent
    private var bottomContent: some View {
        HStack {
            Text(bubbleStatus == .inProgress ? fileSize : duration)
                .font(values.timestampFont)
                .foregroundStyle(.secondary)
                .padding(.bottom, -2)
            
            Spacer()
            
            Conversations_BubbleEditedTimestampReadReceiptsView(
                timestamp: timestamp,
                status: status,
                shouldAnimate: shouldAnimate
            )
        }
        .frame(width: spectrumWidth)
    }
    
    // MARK: - vContainer
    private var vContainer: some View {
        VStack(spacing: 7) {
            spectrumFrame
                .overlay {
                    switch bubbleStatus {
                    case .active, .inactive, .failed, .paused:
                        spectrum
                        slider
                    default:
                        EmptyView()
                    }
                }
                .overlay {
                    switch bubbleStatus {
                    case .inProgress:
                        progressBar
                    default:
                        EmptyView()
                    }
                }
            
            bottomContent
        }
    }
    
    // MARK: - image
    private var image: some View {
        WebImage(
            url: .init(string: "https://www.akc.org/wp-content/uploads/2018/08/nervous_lab_puppy-studio-portrait-lg-500x500.jpg"),
            options: [.scaleDownLargeImages, .retryFailed, .progressiveLoad]
        )
        .resizable()
        .defaultBColorPlaceholder()
        .scaledToFill()
        .frame(width: imageSize, height: imageSize)
        .clipShape(Circle())
        .overlay(alignment: .bottomTrailing) {
            let image: UIImage = .init(named: "micStroked") ?? UIImage()
            let imageWidth: CGFloat = image.size.width
            
            Image(.micStroked)
                .renderingMode(.template)
                .foregroundStyle(.bubbleSender)
                .overlay {
                    Image(.mic)
                        .renderingMode(.template)
                        .foregroundStyle(.micPlaybackNCancelIcons)
                }
                .offset(x: imageWidth/2)
        }
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - onProgressBarAppear
    private func onProgressBarAppear() {
        alignment = .bottomTrailing
    }
}
