//
//  Conversations_StickerPlaceholderShapeView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-12.
//

import SwiftUI

struct Conversations_StickerPlaceholderShapeView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    let values = MessageBubbleValues.self
    let cornerRadius: CGFloat = 45
    let lineWidth: CGFloat = 4
    var strokeColor: Color {
        .primary
        .opacity(colorScheme == .dark ? 0.185 : 0.057)
    }
    var fillColor: Color {
        .primary
        .opacity(colorScheme == .dark ? 0.102 : 0.04)
    }
    
    // MARK: - BODY
    var body: some View {
        Conversations_StickerPlaceholderShape(cornerRadius)
            .stroke(
                strokeColor,
                style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)
            )
            .frame(
                width: values.stickerFrameSize - lineWidth,
                height: values.stickerFrameSize - lineWidth
            )
            .overlay {
                Conversations_StickerPlaceholderShape(cornerRadius + lineWidth/2)
                    .fill(fillColor)
                    .frame(
                        width: values.stickerFrameSize,
                        height: values.stickerFrameSize
                    )
            }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_StickerPlaceholderShapeView") {
    Conversations_StickerPlaceholderShapeView().previewViewModifier
}
