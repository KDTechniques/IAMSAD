//
//  Conversations_ReplyBubbleTypeView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-12.
//

import SwiftUI

struct Conversations_ReplyBubbleTypeView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    // MARK: - PROPERTIES
    let userName: String = "Wifey ❤️"
    let replyText: String = "Hi there."
    let timestamp: String = "03:15 PM"
    let status: ReadReceiptStatusTypes = .seen
    let stripColor: Color = .cyan
    let mediaType: ConversationMediaTypes
    let replyingTo: MessageBubbleUserTypes = .receiver
    let userType: MessageBubbleUserTypes = .sender
    let showPointer: Bool = true
    let shouldAnimate: Bool = false
    
    let values = MessageBubbleValues.self
    var replyBubbleValues: ReplyBubbleValues.Type { values.replyBubbleValues }
    var outerPadding: (Edge.Set, CGFloat) { replyBubbleValues.outerPadding }
    
    // MARK: - INITIALIZER
    
    
    // MARK: - BODY
    var body: some View {
        Conversations_PrimaryNSecondaryBubbleTypeView(
            text: replyText,
            timestamp: timestamp,
            status: status,
            userType: userType,
            showPointer: showPointer,
            shouldAnimate: shouldAnimate,
            withContent: true
        ) { type, width in
            var messageBubbleWidth: CGFloat {
                width + (type == .text ? values.innerHPadding : 0)
            }
            
            Group {
                switch mediaType {
                case .text:
                    textBased
                case .photo:
                    photoBased(messageBubbleWidth)
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
            .background(userType == .sender ? .replyShapeSender : .replyShapeReceiver)
            .clipShape(CustomRoundedRectangleShape(cornerRadius: values.bubbleShapeValues.cornerRadius - outerPadding.1))
            .padding(outerPadding.0, outerPadding.1)
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_ReplyBubbleTypeView") {
    Conversations_ReplyBubbleTypeView(mediaType: .photo)
}

// MARK: -  EXTENSIONS
extension Conversations_ReplyBubbleTypeView {
    // MARK: - textBased
    private var textBased: some View {
        VStack {
            Text(userName)
                .font(replyBubbleValues.userTypeFont)
        }
    }
    
    // MARK: - photoBased
    private func photoBased(_ messageBubbleWidth: CGFloat) -> some View {
        Conversations_PhotoBasedReplyBubbleView(
            messageBubbleWidth: messageBubbleWidth,
            stripColor: stripColor,
            mediaType: mediaType,
            userName: userName
        )
    }
    
    // MARK: - stickerBased
    private var stickerBased: some View {
        VStack {
            Text("Wifey ❤️😘")
                .font(replyBubbleValues.userTypeFont)
        }
    }
    
    // MARK: - gifBased
    private var gifBased: some View {
        VStack {
            Text("Wifey ❤️😘")
                .font(replyBubbleValues.userTypeFont)
        }
    }
    
    // MARK: - videoBased
    private var videoBased: some View {
        VStack {
            Text("Wifey ❤️😘")
                .font(replyBubbleValues.userTypeFont)
        }
    }
    
    // MARK: - voiceRecordBased
    private var voiceRecordBased: some View {
        VStack {
            Text("Wifey ❤️😘")
                .font(replyBubbleValues.userTypeFont)
        }
    }
}
