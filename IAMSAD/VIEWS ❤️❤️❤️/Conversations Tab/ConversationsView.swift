//
//  ConversationsView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-18.
//

import SwiftUI
import SDWebImageSwiftUI

struct ConversationsView: View {
    // MARK: - PROPERTIES
    let url: URL? = .init(string: "https://picsum.photos/id/\(Int.random(in: 1...500))/300")
    let imageSize: CGFloat = 60
    let badgeSize: CGFloat = 15
    let badgeType: VerifiedBadgeTypes = .blue
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 12) {
            WebImage(url: url, options: [.scaleDownLargeImages, .continueInBackground])
                .resizable()
                .defaultBColorPlaceholder
                .scaledToFill()
                .frame(width: imageSize, height: imageSize)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    HStack(spacing: 4) {
                        Text("Deepashika Sajeewanie")
                            .font(.headline)
                            .lineLimit(1)
                        
                        Image(systemName: "checkmark.seal.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: badgeSize, height: badgeSize)
                            .fontWeight(.semibold)
                            .foregroundStyle(badgeType == .blue ? .cyan : .orange)
                    }
                    
                    Spacer()
                    
                    Text("8:13 AM")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                HStack(alignment: .bottom) {
                    Text("Don't you worry okay, i will help you go through this. Leave a message if you need me anytime. I'll get back to you as soon as i can.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                    
                    Spacer()
                    
                    Text("on my post")
                        .font(.caption2)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .background(Color(uiColor: .systemGray5))
                        .clipShape(.rect(cornerRadius: 5))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
    }
}

// MARK: - PREVIEWS
#Preview("ConversationsView") {
    ConversationsView()
        .frame(width: screenWidth, height: screenHeight)
        .background(.tabBarNSystemBackground)
        .previewViewModifier
}
