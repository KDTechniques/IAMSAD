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
    
    // MARK: - INITILAIZER
    init(urlString: String) {
        self.urlString = urlString
    }
    
    // MARK: - PRIVATE PROPERTIES
    let values = VoiceRecordBubbleValues.self
    
    // MARK: - BODY
    var body: some View {
        image.overlay(alignment: .bottomTrailing) { mic }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_VoiceRecordPrimaryPlainBubble_ImageView") {
    Conversations_VoiceRecordPrimaryPlainBubble_ImageView(
        urlString: "https://www.akc.org/wp-content/uploads/2018/08/nervous_lab_puppy-studio-portrait-lg-500x500.jpg"
    )
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
        .resizable()
        .defaultBColorPlaceholder()
        .scaledToFill()
        .frame(width: values.imageSize, height: values.imageSize)
        .clipShape(Circle())
    }
    
    // MARK: - mic
    @ViewBuilder
    private var mic: some View {
        Image(.micStroked)
            .renderingMode(.template)
            .foregroundStyle(.bubbleSender)
            .overlay {
                Image(.mic)
                    .renderingMode(.template)
                    .foregroundStyle(.micPlaybackNCancelIcons)
            }
            .offset(x: values.strokedMicImageWidth/2)
    }
}
