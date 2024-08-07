//
//  TikTokBasedSecondaryBubbleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-27.
//

import SwiftUI
import SDWebImageSwiftUI

struct TikTokBasedSecondaryBubbleView: View {
    // MARK: - PROPERTIES
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    let tiktokObject: TikTokInfoModel
    
    let values = MessageBubbleValues.self
    
    var secondaryBubbleValues: SecondaryBubbleValues.Type {
        values.secondaryBubbleValues
    }
    
    var socialMediaBubbleValues: SocialMediaBubbleValues.Type {
        values.socialMediaBubbleValues
    }
    
    var height: CGFloat {
        values.socialMediaBubbleValues.getSocialMediaCoverHeight(.tiktok)
    }
    
    var width: CGFloat {
        screenWidth - (values.maxWidthLimitationPadding*2) -
        secondaryBubbleValues.outerPadding.1*2
    }
    
    // MARK: - INITIALIZER
    init(tiktokObject: TikTokInfoModel) {
        self.tiktokObject = tiktokObject
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let _: String = tiktokObject.data.coverPhotoURL {
                coverPhotoBlur
                    .overlay {
                        coverPhoto
                            .overlay {
                                playButton
                            }
                    }
            }
            
            vContainer
        }
        .frame(width: width)
    }
}

// MARK: - PREVIEWS
#Preview("TikTokBasedSecondaryBubbleView") {
    let dataObject: (any Codable) = TikTokInfoModel(data: .init(
        videoURL: "",
        coverPhotoURL: "https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2021/06/TikTok-Selfie.jpg?w=1250&h=1120&crop=1",
        author: .init(nickname: "Beauty Queen 💋❤️"),
        likesCount: 3100,
        commentCount: 1450,
        title: "This is a TikTok based sample title."
    ))
    
    return TikTokBasedSecondaryBubbleView(tiktokObject: dataObject as! TikTokInfoModel)
}

//MARK: EXTENSIONS
extension TikTokBasedSecondaryBubbleView {
    // MARK: - coverPhoto
    private var coverPhotoBlur: some View {
        getCoverPhoto(true)
    }
    
    // MARK: - coverPhotoBlur
    private var coverPhoto: some View {
        getCoverPhoto(false)
    }
    
    private func getCoverPhoto(_ withBlur: Bool) -> some View {
        WebImage(
            url: .init(string: tiktokObject.data.coverPhotoURL ?? ""),
            options: [.scaleDownLargeImages, .retryFailed, .progressiveLoad]
        )
        .placeholder { Color.defaultBColorPlaceholder() }
        .resizable()
        .scaledToFill()
        .blur(radius: withBlur ? 20 : 0)
        .frame(width: width - (withBlur ? 0 : 100))
        .frame(height: height - socialMediaBubbleValues.getTextBasedVContainerFullHeight(dynamicTypeSize))
        .clipped()
    }
    
    // MARK: - playButton
    private var playButton: some View {
        Image(systemName: "play.circle.fill")
            .symbolRenderingMode(.palette)
            .resizable()
            .scaledToFit()
            .foregroundStyle(.white, .black.opacity(0.5))
            .frame(width: 58, height: 58)
            .onTapGesture {
                // play action goes here...
                print("Playback Directed!")
            }
    }
    
    // MARK: - vContainer
    private var vContainer: some View {
        VStack(alignment: .leading, spacing: socialMediaBubbleValues.titleToDescriptionSpacing) {
            authorName
            
            VStack(alignment: .leading, spacing: socialMediaBubbleValues.descriptionToDomainSpacing) {
                likesNCommentCount
                urlText
            }
            .foregroundStyle(.secondary)
        }
        .lineLimit(1)
        .padding(.horizontal, secondaryBubbleValues.vContainerHPadding)
        .padding(.vertical, socialMediaBubbleValues.textVContainerVerticalPadding)
    }
    
    // MARK: - authorName
    private var authorName: some View {
        Text("TikTok · \(tiktokObject.data.author.nickname)")
            .font(socialMediaBubbleValues.titleTextFont)
            .opacity(socialMediaBubbleValues.titleTextOpacity)
    }
    
    // MARK: - likesNCommentCount
    private var likesNCommentCount: some View {
        Text("\(tiktokObject.data.likesCount.intToKMString()) likes, \(tiktokObject.data.commentCount.intToKMString()) comments. \"\(tiktokObject.data.title)\"")
            .font(socialMediaBubbleValues.descriptionTextFont)
        
    }
    
    // MARK: - urlText
    private var urlText: some View {
        Text(SocialMediaTypes.tiktok.rawValue)
            .font(socialMediaBubbleValues.domainTextFont)
    }
}
