//
//  Conversations_AudioPrimaryPlainBubbleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-01.
//

import SwiftUI
import SDWebImageSwiftUI

struct Conversations_AudioPrimaryPlainBubbleView: View {
    var body: some View {
        Conversations_MessageBubbleView(direction: .right, showPointer: true) {
//            HStack(spacing: 0) {
//                Image(systemName: "")
//                .resizable()
//                .defaultBColorPlaceholder(MessageBubbleValues.anyImagePlaceholderColor)
//                .scaledToFill()
//                .frame(width: values.imageSize, height: values.imageSize)
//                .clipShape(Circle())
//            }
        }
    }
}

#Preview("Conversations_AudioPrimaryPlainBubbleView") {
    Conversations_AudioPrimaryPlainBubbleView()
        .previewViewModifier
}
