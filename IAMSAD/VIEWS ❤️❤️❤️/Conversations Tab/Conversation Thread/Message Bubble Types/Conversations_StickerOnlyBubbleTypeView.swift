//
//  Conversations_StickerOnlyBubbleTypeView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-11.
//

import SwiftUI
import SDWebImageSwiftUI

struct Conversations_StickerOnlyBubbleTypeView: View {
    // MARK: - PROPERTIRS
    
    // MARK: - INITIALIZER
    
    // MARK: - BODY
    var body: some View {
        VStack {
            WebImage(url: .init(string: "https://media2.giphy.com/media/3o6gE51uXycrKW6D84/200w.gif"), options: [.scaleDownLargeImages, .retryFailed])
                .resizable()
                .defaultBColorPlaceholder()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .background(.yellow.opacity(0.5))
                .clipped()
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_StickerOnlyBubbleTypeView") {
    Conversations_StickerOnlyBubbleTypeView()
}
