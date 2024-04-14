//
//  Conversations_ReplyBubbleTypeView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-12.
//

import SwiftUI

struct Conversations_ReplyBubbleTypeView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - PROPERTIES
    let senderColorLight: Color = Color.debug
    let senderColorDark: Color = Color.debug
    let receiverColorLight: Color = Color.debug
    let receiverColorDark: Color = Color.debug
    let mediaType: ConversationMediaTypes = .text
    let replyingTo: MessageBubbleUserTypes = .receiver
    let direction: BubbleShapeValues.Directions = .right
    let showPointer: Bool = true
    
    let colorStripWidth: CGFloat = 4
    let values = MessageBubbleValues.self
    @State private var width: CGFloat = 0
    
    // MARK: - INITIALIZER
    
    // MARK: - BODY
    var body: some View {
        Conversations_MessageBubbleView(direction: direction, showPointer: showPointer) {
            VStack {
                Group {
                    switch mediaType {
                    case .text:
                        textBased
                    case .photo:
                        photoBased
                    case .sticker:
                        stickerBased
                    case .gif:
                        gifBased
                    case .video:
                        videoBased
                    case .voiceRecord:
                        voiceRecordBased
                    }
                }
                .padding()
                .overlay(alignment: .leading) {
                    getStripColor(replyingTo)
                        .frame(width: colorStripWidth)
                }
                .frame(width: width, alignment: .leading)
                .background(direction == .right ? .replyShapeSender : .replyShapeReceiver)
                .clipShape(CustomRoundedRectangleShape(cornerRadius: values.bubbleShapeValues.cornerRadius - 5))
                
                Text("this is going to be the reply text. 1234567890")
                    .geometryReaderDimensionViewModifier($width, dimension: .width)
            }
            .padding([.top, .horizontal], 5)
            .padding(.bottom, 10)
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_ReplyBubbleTypeView") {
    Conversations_ReplyBubbleTypeView()
}

// MARK: -  EXTENSIONS
extension Conversations_ReplyBubbleTypeView {
    // MARK: - getStripColor
    private func getStripColor(_ replyingTo: MessageBubbleUserTypes) -> Color {
        switch replyingTo {
        case .receiver:
            colorScheme == .dark ? receiverColorDark : receiverColorLight
        case .sender:
            colorScheme == .dark ? senderColorDark : senderColorLight
        }
    }
    
    // MARK: - textBased
    private var textBased: some View {
        VStack {
            Text("Wifey ❤️😘")
                .font(.callout.weight(.semibold))
        }
    }
    
    // MARK: - photoBased
    private var photoBased: some View {
        VStack {
            Text("Wifey ❤️😘")
                .font(.callout.weight(.semibold))
        }
    }
    
    // MARK: - stickerBased
    private var stickerBased: some View {
        VStack {
            Text("Wifey ❤️😘")
                .font(.callout.weight(.semibold))
        }
    }
    
    // MARK: - gifBased
    private var gifBased: some View {
        VStack {
            Text("Wifey ❤️😘")
                .font(.callout.weight(.semibold))
        }
    }
    
    // MARK: - videoBased
    private var videoBased: some View {
        VStack {
            Text("Wifey ❤️😘")
                .font(.callout.weight(.semibold))
        }
    }
    
    // MARK: - voiceRecordBased
    private var voiceRecordBased: some View {
        VStack {
            Text("Wifey ❤️😘")
                .font(.callout.weight(.semibold))
        }
    }
}
