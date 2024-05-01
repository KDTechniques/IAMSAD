//
//  Conversations_PrimaryNSecondaryBubbleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-10.
//

import SwiftUI

struct Conversations_PrimaryNSecondaryBubbleView<T: View>: View {
    // MARK: - PROPERTIES
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    let primaryMediaType: ConversationMediaTypes
    let text: String
    let timestamp: String
    let status: ReadReceiptStatusTypes
    let userType: MessageBubbleUserTypes
    let showPointer: Bool
    let shouldAnimate: Bool
    let withSecondaryContent: Bool
    let secondaryContent: (ConversationMediaTypes, CGFloat) -> T
    
    @State private var bubbleWidth: CGFloat = 0
    @State private var height: CGFloat = 0
    
    let values = MessageBubbleValues.self
    
    var vStackAlignment: HorizontalAlignment {
        primaryMediaType == .text ? .leading : .center
    }
    
    var innerHPadding: CGFloat {
        primaryMediaType == .text ? values.innerHPadding : 0
    }
    
    var innerVPadding: CGFloat {
        primaryMediaType == .text ? values.innerVPadding : 4
    }
    
    // MARK: - INITILAIZER
    init(
        primaryMediaType: ConversationMediaTypes,
        text: String,
        timestamp: String,
        status: ReadReceiptStatusTypes,
        userType: MessageBubbleUserTypes,
        showPointer: Bool,
        shouldAnimate: Bool,
        withSecondaryContent: Bool,
        @ViewBuilder secondaryContent: @escaping (ConversationMediaTypes, CGFloat) -> T = { _, _  in EmptyView()
        }
    ) {
        self.primaryMediaType = primaryMediaType
        self.text = text
        self.timestamp = timestamp
        self.status = status
        self.userType = userType
        self.showPointer = showPointer
        self.shouldAnimate = shouldAnimate
        self.withSecondaryContent = withSecondaryContent
        self.secondaryContent = secondaryContent
    }
    
    // MARK: - BODY
    var body: some View {
        if !withSecondaryContent { // (Primary Bubble Types / Sticker Only Bubble Type) Only
            switch primaryMediaType {
            case .text:
                Color.debug
                
            case .linkTextOnly:
                Color.debug
                
            case .voiceRecord:
                Color.debug
                
            case .audio:
                Color.debug
                
            case .collage:
                Color.debug
                
            case .photo:
                Color.debug
                
            case .video:
                Color.debug
                
            case .gif:
                Color.debug
                
            case .sticker:
                Conversations_StickerOnlyBubbleTypeView(
                    url: .init(string: "https://cdn.pixabay.com/animation/2022/10/11/09/05/09-05-26-529_512.gif"),
                    timestamp: timestamp,
                    userType: userType
                )
                
            default:
                EmptyView()
            }
        } else { // Secondary + Primary Bubble Types
            Conversations_MessageBubbleView(
                direction: values.getDirection(userType),
                showPointer: showPointer
            ) {
                VStack(alignment: vStackAlignment, spacing: 0) {
                    // MARK: - SECONDARY CONTENT
                    secondaryContent(primaryMediaType, bubbleWidth)
                    
                    // MARK: - PRIMARY CONTENT
                    Group {
                        switch primaryMediaType {
                        case .text:
                            textBased
                        case .sticker:
                            stickerBased
                        default: // more to come here...
                            EmptyView()
                        }
                    }
                    .padding(.horizontal, innerHPadding)
                    .padding(.vertical, innerVPadding)
                    .geometryReaderDimensionViewModifier($bubbleWidth, dimension: .width)
                }
                .overlay(alignment: .bottomTrailing) {
                    if withSecondaryContent {
                        timestampNReadReceipts
                            .padding(.trailing, values.innerHPadding)
                            .padding(.bottom, values.innerVPadding)
                    }
                }
                .geometryReaderDimensionViewModifier($height, dimension: .height)
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_PrimaryNSecondaryBubbleView") {
    ScrollView(.vertical) {
        LazyVStack {
            Conversations_PrimaryNSecondaryBubbleView(
                primaryMediaType: .sticker,
                text: "Hello there 👋👋👋",
                timestamp: "06:12 PM",
                status: .random(),
                userType: .sender,
                showPointer: true,
                shouldAnimate: .random(),
                withSecondaryContent: false
            ) { _, _ in }
        }
    }
}

// MARK: - EXTENSIONS
extension Conversations_PrimaryNSecondaryBubbleView {
    // MARK: - textBased
    private var textBased: some View {
        Conversations_TextBasedPrimaryBubbleView(
            text: text,
            timestamp: timestamp,
            status: status,
            shouldAnimate: shouldAnimate,
            height: height,
            withSecondaryContent: withSecondaryContent
        )
    }
    
    // MARK: - stickerBased
    @ViewBuilder
    private var stickerBased: some View {
        if withSecondaryContent {
            Image(.follower3)
                .resizable()
                .scaledToFill()
                .frame(width: values.stickerFrameSize, height: values.stickerFrameSize)
                .clipped()
                .padding(.bottom, 20)
        }
    }
    
    // MARK: - timestampNReadReceipts
    private var timestampNReadReceipts: some View {
        Conversations_BubbleEditedTimestampReadReceiptsView(
            timestamp: timestamp,
            status: status,
            shouldAnimate: shouldAnimate
        )
    }
}
