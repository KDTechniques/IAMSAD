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
    var ratio: CGFloat { values.stickerFrameSize / 138 }
    var cornerRadius: CGFloat { ratio * 45 }
    var padding: CGFloat { (values.stickerFrameSize - ratio * 55) / 2 }
    var arrowDownSize: CGFloat { padding/41.5 * 13 }
    var lineWidth: CGFloat { ratio * 5 }
    var strokeColor: Color {
        .primary
        .opacity(colorScheme == .dark ? 0.185 : 0.057)
    }
    var fillColor: Color {
        .primary
        .opacity(colorScheme == .dark ? 0.102 : 0.04)
    }
    
    // MARK: - INITIALIZER
    
    
    // MARK: - BODY
    var body: some View {
        Conversations_StickerPlaceholderShape(cornerRadius)
            .stroke(strokeColor, style: .init(lineWidth: lineWidth, lineJoin: .round))
            .frame(width: values.stickerFrameSize, height: values.stickerFrameSize)
            .overlay {
                Conversations_StickerPlaceholderShape(cornerRadius + lineWidth/2)
                    .fill(fillColor)
                    .frame(
                        width: values.stickerFrameSize + lineWidth,
                        height: values.stickerFrameSize + lineWidth
                    )
            }
            .overlay {
                Circle()
                    .fill(.arrowDownCircle)
                    .padding(padding)
                    .overlay {
                        Image(systemName: "arrow.down")
                            .resizable()
                            .scaledToFit()
                            .frame(width: arrowDownSize, height: arrowDownSize)
                            .fontWeight(.semibold)
                            .foregroundStyle(.arrowDown)
                    }
                    .onTapGesture {
                        print("Pressed!")
                    }
            }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_StickerPlaceholderShape") {
    ZStack {
        Color.conversationBackground
            .ignoresSafeArea()
        
        Image(.whatsappchatbackgroundimage)
            .resizable()
            .scaledToFill()
            .frame(width: screenWidth, height: screenHeight)
            .clipped()
            .ignoresSafeArea()
            .opacity(0.25)
        
        Conversations_StickerPlaceholderShapeView()
    }
}
