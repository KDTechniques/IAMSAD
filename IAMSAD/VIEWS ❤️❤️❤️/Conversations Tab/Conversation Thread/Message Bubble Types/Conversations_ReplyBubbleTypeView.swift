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
    let userName: String = "Wifey ❤️😘"
    let replyText: String = ""
    let timestamp: String = "03:15 PM"
    let status: ReadReceiptStatusTypes = .seen
    let stripColor: Color = .cyan
    let mediaType: ConversationMediaTypes
    let replyingTo: MessageBubbleUserTypes = .random()
    let userType: MessageBubbleUserTypes = .random()
    let showPointer: Bool = .random()
    let shouldAnimate: Bool = .random()
    
    let values = MessageBubbleValues.self
    var replyBubbleValues: ReplyBubbleValues.Type { values.replyBubbleValues }
    var outerPadding: (Edge.Set, CGFloat) { replyBubbleValues.outerPadding }
    var replyBubbleWidth: CGFloat {
        (outerPadding.1 * 2) +
        replyBubbleValues.stripWidth +
        (replyBubbleValues.userTypeTextHPadding * 2) +
        userName.widthOfHString(usingFont: .from(replyBubbleValues.userTypeFont), dynamicTypeSize) +
        replyBubbleValues.mediaContentSize
    }
    
    // MARK: - INITIALIZER
    
    
    // MARK: - BODY
    var body: some View {
        Conversations_TextOnlyBubbleTypeView(
            text: "පුක",
            timestamp: timestamp,
            status: status,
            userType: userType,
            showPointer: showPointer,
            shouldAnimate: shouldAnimate,
            withContent: true
        ) { width in
            Group {
                switch mediaType {
                case .text:
                    textBased
                case .photo:
                    photoBased(width+values.innerHPadding)
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
            .frame(minWidth: 0)
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
    @ViewBuilder
    private func photoBased(_ messageBubbleWidth: CGFloat) -> some View {
        var shouldExpand: Bool { replyBubbleWidth < messageBubbleWidth }
        
        HStack(spacing: replyBubbleValues.userTypeTextHPadding) {
            stripColor
                .frame(width: replyBubbleValues.stripWidth)
            
            VStack(alignment: .leading, spacing: replyBubbleValues.userTypeToMediaTypeBadgePadding(mediaType)) {
                Text(userName)
                    .font(replyBubbleValues.userTypeFont)
                    .lineLimit(1)
                
                Conversations_PhotoBadgeView()
            }
            .padding(.trailing, shouldExpand ? -replyBubbleValues.userTypeTextHPadding : 0)
            
            if shouldExpand {
                Spacer()
            }
            
            Image(.follower1)
                .resizable()
                .scaledToFill()
                .frame(width: replyBubbleValues.mediaContentSize)
                .clipped()
            
        }
        .frame(height: replyBubbleValues.innerBubbleFrameHeight)
        .maxWidth(shouldExpand: shouldExpand, messageBubbleWidth: messageBubbleWidth)
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

extension View {
    @ViewBuilder
    fileprivate func maxWidth(shouldExpand: Bool, messageBubbleWidth: CGFloat) -> some View {
        if shouldExpand {
            self
                .frame(maxWidth: messageBubbleWidth)
        } else {
            self
        }
    }
}
