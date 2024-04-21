//
//  Conversations_PhotoVideoGIFLinkBasedSecondaryBubbleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-17.
//

import SwiftUI
import SDWebImageSwiftUI

struct Conversations_PhotoVideoGIFLinkBasedSecondaryBubbleView: View {
    // MARK: - PROPERTIES
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    let secondaryMediaType: ConversationMediaTypes
    let messageBubbleWidth: CGFloat
    let stripColor: Color
    let userName: String
    
    // MARK: - INITIALIZER
    init(
        secondaryMediaType: ConversationMediaTypes,
        messageBubbleWidth: CGFloat,
        stripColor: Color,
        userName: String
    ) {
        self.secondaryMediaType = secondaryMediaType
        self.messageBubbleWidth = messageBubbleWidth
        self.stripColor = stripColor
        self.userName = userName
    }
    
    // MARK: - PRIVATE PROPERTIES
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
    
    var shouldExpand: Bool { replyBubbleWidth < messageBubbleWidth }
    var height: CGFloat {
        replyBubbleValues.innerBubbleFrameHeight +
        (secondaryMediaType == .link ? 17 : 0)
    }
    
    // MARK: - BODY
    var body: some View {
        switch secondaryMediaType {
        case .photo, .video, .gif, .link:
            HStack(spacing: replyBubbleValues.userTypeTextHPadding) {
                strip
                verticalContainer
                spacer
                
                switch secondaryMediaType {
                case .photo:
                    photoBased
                case .video:
                    videoBased
                case .gif:
                    gifBased
                case .link:
                    linkBased
                default:
                    EmptyView()
                }
            }
            .frame(height: height)
            .setMaxWidthViewModifier(shouldExpand: shouldExpand, messageBubbleWidth: messageBubbleWidth)
        default:
            EmptyView()
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_SecondaryBubbleView") {
    Conversations_SecondaryBubbleView(primaryMediaType: .sticker, secondaryMediaType: .link)
        .previewViewModifier
}

#Preview("Conversations_PhotoVideoGIFLinkBasedSecondaryBubbleView") {
    Conversations_PhotoVideoGIFLinkBasedSecondaryBubbleView(
        secondaryMediaType: .gif,
        messageBubbleWidth: 100,
        stripColor: .debug,
        userName: "Wifey ❤️😘"
    )
    .previewViewModifier
}

// MARK: - EXTENSIONS
extension Conversations_PhotoVideoGIFLinkBasedSecondaryBubbleView {
    // MARK: - strip
    private var strip: some View {
        stripColor
            .frame(width: replyBubbleValues.stripWidth)
    }
    
    // MARK: - verticalContainer
    private var verticalContainer: some View {
        VStack(alignment: .leading, spacing: replyBubbleValues.userTypeToMediaTypeBadgePadding(.photo)) {
            Text(userName)
                .font(replyBubbleValues.userTypeFont)
                .lineLimit(1)
            
            switch secondaryMediaType {
            case .photo:
                Conversations_PhotoBadgeView()
            case .video:
                Conversations_VideoBadgeView()
            case .gif:
                Conversations_GIFBadgeView()
            case .link:
                Conversations_MediaBadgeTextView(text: "https://youtu.be/fdZwRDv9OWI?si=XRE-8O3nr-JvMXRO")
            default:
                EmptyView()
            }
        }
        .padding(.trailing, shouldExpand ? -replyBubbleValues.userTypeTextHPadding : 0)
    }
    
    // MARK: - spacer
    @ViewBuilder
    private var spacer: some View {
        if shouldExpand {
            Spacer()
        }
    }
    
    // MARK: - photo
    @ViewBuilder
    private var photoBased: some View {
        let url: URL? = Bundle.main.url(forResource: "photo", withExtension: "jpg")
        
        WebImage(url: url, options: [.scaleDownLargeImages, .retryFailed, .progressiveLoad])
            .resizable()
            .defaultBColorPlaceholder()
            .scaledToFill()
            .frame(width: replyBubbleValues.mediaContentSize)
            .clipped()
    }
    
    // MARK: - videoBased
    private var videoBased: some View {
        Group {
            if let videoURL: URL = Bundle.main.url(forResource: "video", withExtension: "mp4"),
               let image: UIImage = Utilities.getThumbnailFrom(videoURL) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Color(uiColor: .systemGray6)
            }
        }
        .frame(width: replyBubbleValues.mediaContentSize)
        .clipped()
    }
    
    // MARK: - gifBased
    @ViewBuilder
    private var gifBased: some View {
        let url: URL? = .init(string: "https://i0.wp.com/www.galvanizeaction.org/wp-content/uploads/2022/06/Wow-gif.gif?fit=450%2C250&ssl=1")
        
        WebImage(url: url, options: [.scaleDownLargeImages, .retryFailed, .progressiveLoad])
            .resizable()
            .defaultBColorPlaceholder()
            .scaledToFill()
            .frame(width: replyBubbleValues.mediaContentSize)
            .clipped()
    }
    
    // MARK: - linkBased
    @ViewBuilder
    private var linkBased: some View {
        let urlString: String = "https://img.youtube.com/vi/xtAL2x58hns/mqdefault.jpg"
        
        if let url: URL = .init(string: urlString) {
            WebImage(url: url, options: [.scaleDownLargeImages, .retryFailed, .progressiveLoad])
                .resizable()
                .defaultBColorPlaceholder()
                .scaledToFill()
                .frame(width: replyBubbleValues.mediaContentSize)
                .clipped()
        }
    }
}

extension View {
    // MARK: - setMaxWidthViewModifier
    @ViewBuilder
    fileprivate func setMaxWidthViewModifier(shouldExpand: Bool, messageBubbleWidth: CGFloat) -> some View {
        if shouldExpand {
            self
                .frame(maxWidth: messageBubbleWidth)
        } else {
            self
        }
    }
}
