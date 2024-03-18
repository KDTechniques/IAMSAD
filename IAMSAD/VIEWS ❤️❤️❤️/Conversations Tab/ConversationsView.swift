//
//  ConversationsView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-18.
//

import SwiftUI
import SDWebImageSwiftUI

enum ConversationTypes: Equatable {
    case conversationOnPost(isOnMyPost: Bool)
    case conversationOverDirectMessage
}

struct ConversationsView: View {
    // MARK: - PROPERTIES
    let url: URL? = .init(string: "https://picsum.photos/id/\(Int.random(in: 1...500))/300")
    
    // MARK: - BODY
    var body: some View {
        List {
            ForEach(0...200, id: \.self) { index in
                Conversations_ListItemView(
                    accountType: .anonymous,
                    avatar: Avatar.shared.publicAvatarsArray[index],
                    imageURL: Bundle.main.url(forResource: Avatar.shared.publicAvatarsArray[index].imageName, withExtension: "png"),
                    name: "Deepashika Sajeewanie",
                    badgeType: .blue,
                    time: "6:24 PM",
                    text: "Don't you worry okay, i will help you go through this. Leave a message if you need me anytime. I'll get back to you as soon as i can.",
                    conversationType: .conversationOnPost(isOnMyPost: Bool.random())
                )
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
    }
}

// MARK: - PREVIEWS
#Preview("ConversationsView") {
    ConversationsView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.tabBarNSystemBackground)
        .previewViewModifier
}
