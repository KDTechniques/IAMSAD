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
    var socialMediaType: SocialMediaTypes? {
        Utilities.getSocialMediaType(by: urlString)
    }
    
    var secondaryBubbleValues: SecondaryBubbleValues.Type { values.secondaryBubbleValues }
    var outerPadding: (Edge.Set, CGFloat) { secondaryBubbleValues.outerPadding }
    
    var secondaryBubbleWidth: CGFloat {
        (outerPadding.1 * 2) +
        secondaryBubbleValues.stripWidth +
        (secondaryBubbleValues.vContainerHPadding * 2) +
        userName.widthOfHString(usingFont: .from(secondaryBubbleValues.userTypeFont), dynamicTypeSize) +
        secondaryBubbleValues.mediaContentSize
    }
    
    var shouldExpand: Bool { secondaryBubbleWidth < messageBubbleWidth }
    
    var height: CGFloat {
        switch secondaryMediaType {
        case .text, .photo, .sticker, .gif, .video:
            secondaryBubbleValues.innerBubbleFrameHeight
            
        case .linkWithPreview:
            secondaryBubbleValues.innerBubbleFrameHeight + 17
            
        case .socialMediaInfo:
            switch socialMediaType {
            case .facebook:
                0
            case .instagram:
                0
            case .youtube:
                0
            case .tiktok:
                values.socialMediaBubbleValues.getSocialMediaCoverHeight(.tiktok)
            case nil:
                0
            }
        default:
            0
        }
    }
    
    let urlString: String = "https://vt.tiktok.com/ZSFWcs3pN/"
    let dataObject: (any Codable)? = TikTokInfoModel(data: .init(
        videoURL: "",
        coverPhotoURL: "https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2021/06/TikTok-Selfie.jpg?w=1250&h=1120&crop=1",
        author: .init(nickname: "Beauty Queen 💋❤️"),
        likesCount: 3100,
        commentCount: 1450,
        title: "This is a TikTok based sample title."
    ))
    
    // MARK: - BODY
    var body: some View {
        switch secondaryMediaType {
        case .photo, .video, .gif, .linkWithPreview, .socialMediaInfo:
            HStack(spacing: secondaryBubbleValues.vContainerHPadding) {
                if secondaryMediaType != .socialMediaInfo {
                    strip
                    verticalContainer
                    spacer
                }
                
                switch secondaryMediaType {
                case .photo:
                    photoBased
                case .video:
                    videoBased
                case .gif:
                    gifBased
                case .linkWithPreview:
                    linkWithPreviewBased
                case .socialMediaInfo:
                    socialMediaInfoBased
                default:
                    EmptyView()
                }
            }
            .setHeight(height: height, dataObject: dataObject, socialMediaType: socialMediaType)
            //            .setMaxWidthViewModifier(shouldExpand: shouldExpand, messageBubbleWidth: messageBubbleWidth)
        default:
            EmptyView()
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_SecondaryBubbleView") {
    Conversations_SecondaryBubbleView(
        model: .getRandomMockObject(),
        primaryMediaType: .sticker,
        secondaryMediaType: .socialMediaInfo
    )
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
            .frame(width: secondaryBubbleValues.stripWidth)
    }
    
    // MARK: - verticalContainer
    private var verticalContainer: some View {
        VStack(alignment: .leading, spacing: secondaryBubbleValues.userTypeToMediaTypeBadgePadding(.photo)) {
            Text(userName)
                .font(secondaryBubbleValues.userTypeFont)
                .lineLimit(1)
            
            switch secondaryMediaType {
            case .photo:
                Conversations_PhotoBadgeView()
            case .video:
                Conversations_VideoBadgeView()
            case .gif:
                Conversations_GIFBadgeView()
            case .linkWithPreview:
                Conversations_MediaBadgeTextView(text: "https://youtu.be/fdZwRDv9OWI?si=XRE-8O3nr-JvMXRO")
            default:
                EmptyView()
            }
        }
        .padding(.trailing, shouldExpand ? -secondaryBubbleValues.vContainerHPadding : 0)
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
        
        WebImage(
            url: url,
            options: [.scaleDownLargeImages, .retryFailed, .progressiveLoad]
        ) { $0 } placeholder: {
            Color.defaultBColorPlaceholder()
        }
        .resizable()
        .scaledToFill()
        .frame(width: secondaryBubbleValues.mediaContentSize)
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
        .frame(width: secondaryBubbleValues.mediaContentSize)
        .clipped()
    }
    
    // MARK: - gifBased
    @ViewBuilder
    private var gifBased: some View {
        let url: URL? = .init(string: "https://i0.wp.com/www.galvanizeaction.org/wp-content/uploads/2022/06/Wow-gif.gif?fit=450%2C250&ssl=1")
        
        WebImage(
            url: url,
            options: [.scaleDownLargeImages, .retryFailed, .progressiveLoad]
        ) { $0 } placeholder: {
            Color.defaultBColorPlaceholder()
        }
        .resizable()
        .scaledToFill()
        .frame(width: secondaryBubbleValues.mediaContentSize)
        .clipped()
    }
    
    // MARK: - linkWithPreviewBased
    @ViewBuilder
    private var linkWithPreviewBased: some View {
        let urlString: String = "https://img.youtube.com/vi/fdZwRDv9OWI/mqdefault.jpg"
        
        WebImage(
            url: .init(string: urlString),
            options: [.scaleDownLargeImages, .retryFailed, .progressiveLoad]
        ) { $0 } placeholder: {
            Color.defaultBColorPlaceholder(.clear)
        }
        .resizable()
        .scaledToFill()
        .frame(width: secondaryBubbleValues.mediaContentSize)
        .clipped()
    }
    
    // MARK: - socialMediaInfoBased
    @ViewBuilder
    private var socialMediaInfoBased: some View {
        if let socialMediaType {
            switch socialMediaType {
            case .facebook:
                Color.debug
            case .instagram:
                Color.debug
            case .youtube:
                Color.debug
            case .tiktok:
                tiktokBased
            }
        }
    }
    
    // MARK: - tiktokBased
    @ViewBuilder
    private var tiktokBased: some View {
        if let tiktokObject: TikTokInfoModel = dataObject as? TikTokInfoModel {
            TikTokBasedSecondaryBubbleView(tiktokObject: tiktokObject)
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
    
    // MARK: - setHeight
    @ViewBuilder
    fileprivate func setHeight(
        height: CGFloat,
        dataObject: (any Codable)?,
        socialMediaType: SocialMediaTypes?
    ) -> some View {
        let viewWithHeight: some View = self.frame(height: height, alignment: .top)
        
        if let dataObject,
           let socialMediaType {
            switch socialMediaType {
            case .facebook:
                self
            case .instagram:
                self
            case .youtube:
                self
            case .tiktok:
                if let object: TikTokInfoModel = dataObject as? TikTokInfoModel,
                   object.data.coverPhotoURL != nil {
                    viewWithHeight
                } else {
                    self
                }
            }
        } else {
            viewWithHeight
        }
    }
}


// Mock Social Media URLs

/// https://www.instagram.com/ishee_manisha?igsh=bmx4Z28zOXg3YzJu
/// https://youtu.be/VpDBj5wbu5M
/// https://vt.tiktok.com/ZSFWcs3pN/

