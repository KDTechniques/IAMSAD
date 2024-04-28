//
//  Conversations_SecondaryBubbleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-12.
//

import SwiftUI

struct Conversations_SecondaryBubbleView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    // MARK: - PROPERTIES
    let primaryMediaType: ConversationMediaTypes
    let secondaryMediaType: ConversationMediaTypes
    let userName: String = "Wifey ❤️"
    let replyText: String = "Hi there."
    let timestamp: String = "03:15 PM"
    let status: ReadReceiptStatusTypes = .seen
    let stripColor: Color = .cyan
    let replyingTo: MessageBubbleUserTypes = .receiver
    let userType: MessageBubbleUserTypes = .sender
    let showPointer: Bool = true
    let shouldAnimate: Bool = false
    
    let values = MessageBubbleValues.self
    var secondaryBubbleValues: SecondaryBubbleValues.Type { values.secondaryBubbleValues }
    var outerPadding: (Edge.Set, CGFloat) { secondaryBubbleValues.outerPadding }
    
    // MARK: - INITIALIZER
    
    
    // MARK: - BODY
    var body: some View {
        Conversations_PrimaryNSecondaryBubbleView(
            primaryMediaType: primaryMediaType,
            text: replyText,
            timestamp: timestamp,
            status: status,
            userType: userType,
            showPointer: showPointer,
            shouldAnimate: shouldAnimate,
            withSecondaryContent: true
        ) { type, width in
            var messageBubbleWidth: CGFloat {
                width + (type == .text ? values.innerHPadding : 0)
            }
            
            Group {
                switch secondaryMediaType {
                case .text:
                    textBased
                case .photo, .video, .gif, .linkWithPreview, .linkTextOnly, .socialMediaInfo:
                    photoVideoGIFLinkBased(messageBubbleWidth)
                case .sticker:
                    stickerBased
                case .voiceRecord:
                    voiceRecordBased
                case .audio:
                    audioBased
                default: EmptyView()
                }
            }
            .background(userType == .sender ? .replyShapeSender : .replyShapeReceiver)
            .clipShape(CustomRoundedRectangleShape(cornerRadius: values.bubbleShapeValues.cornerRadius - outerPadding.1))
            .padding(outerPadding.0, outerPadding.1)
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_SecondaryBubbleView") {
    Conversations_SecondaryBubbleView(primaryMediaType: .sticker, secondaryMediaType: .photo)
}

// MARK: -  EXTENSIONS
extension Conversations_SecondaryBubbleView {
    // MARK: - textBased
    private var textBased: some View {
        VStack {
            Text(userName)
                .font(secondaryBubbleValues.userTypeFont)
        }
    }
    
    // MARK: - photoVideoGIFLinkBased
    private func photoVideoGIFLinkBased(_ messageBubbleWidth: CGFloat) -> some View {
        Conversations_PhotoVideoGIFLinkBasedSecondaryBubbleView(
            secondaryMediaType: secondaryMediaType,
            messageBubbleWidth: messageBubbleWidth,
            stripColor: stripColor,
            userName: userName
        )
    }
    
    // MARK: - stickerBased
    private var stickerBased: some View {
        VStack {
            Text("Wifey ❤️😘")
                .font(secondaryBubbleValues.userTypeFont)
        }
    }
    
    // MARK: - voiceRecordBased
    private var voiceRecordBased: some View {
        VStack {
            Text("Wifey ❤️😘")
                .font(secondaryBubbleValues.userTypeFont)
        }
    }
    
    // MARK: - audioBased
    private var audioBased: some View {
        VStack {
            Text("Wifey ❤️😘")
                .font(secondaryBubbleValues.userTypeFont)
        }
    }
}
