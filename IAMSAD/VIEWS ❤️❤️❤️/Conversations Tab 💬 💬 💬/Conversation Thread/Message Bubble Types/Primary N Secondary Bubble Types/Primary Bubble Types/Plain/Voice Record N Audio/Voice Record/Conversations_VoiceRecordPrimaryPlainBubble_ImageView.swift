//
//  Conversations_VoiceRecordPrimaryPlainBubble_ImageView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-03.
//

import SwiftUI
import SDWebImageSwiftUI

struct Conversations_VoiceRecordPrimaryPlainBubble_ImageView: View {
    // MARK: - PROPERTIES
    let urlString: String
    let direction: BubbleShapeValues.Directions
    
    // MARK: - INITILAIZER
    init(urlString: String, direction: BubbleShapeValues.Directions) {
        self.urlString = urlString
        self.direction = direction
    }
    
    // MARK: - PRIVATE PROPERTIES
    let values = VoiceRecordNAudioBubbleValues.self
    
    // MARK: - BODY
    var body: some View {
        image
            .overlay(alignment: direction == .right ? .bottomTrailing : .bottomLeading) { mic }
            .offset(x: values.getImageOffsetX(direction))
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_VoiceRecordPrimaryPlainBubble_ImageView") {
    BubbleVariator_Preview {
        Conversations_VoiceRecordPrimaryPlainBubble_ImageView(
            urlString: "https://www.akc.org/wp-content/uploads/2018/08/nervous_lab_puppy-studio-portrait-lg-500x500.jpg",
            direction: $0 ? .left : .right
        )
    }
    .previewViewModifier
}

// MARK: - EXTENSIONS
extension Conversations_VoiceRecordPrimaryPlainBubble_ImageView {
    // MARK: - image
    private var image: some View {
        WebImage(
            url: .init(string: urlString),
            options: [.scaleDownLargeImages, .retryFailed, .progressiveLoad]
        )
        .placeholder { Color.defaultBColorPlaceholder(MessageBubbleValues.anyImagePlaceholderColor) }
        .resizable()
        .scaledToFill()
        .frame(width: values.imageSize, height: values.imageSize)
        .clipShape(Circle())
    }
    
    // MARK: - mic
    @ViewBuilder
    private var mic: some View {
        Image(.micStroked)
            .renderingMode(.template)
            .foregroundStyle(direction == .right ? .bubbleSender : .bubbleReceiver)
            .overlay {
                Image(.mic)
                    .renderingMode(.template)
                    .foregroundStyle(direction == .right ? .micNActionIconsSender : .appLogoBased)
            }
            .offset(x: values.strokedMicImageWidth/2 * (direction == .right ? 1 : -1))
    }
}
