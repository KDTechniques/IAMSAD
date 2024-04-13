//
//  Conversations_MessageThreadView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-09.
//

import SwiftUI

struct Conversations_MessageThreadView: View {
    
    var body: some View {
        Color.conversationBackground
            .ignoresSafeArea()
            .overlay {
                Image(.whatsappchatbackgroundimage)
                    .resizable()
                    .scaledToFill()
                    .opacity(0.2)
                    .ignoresSafeArea()
            }
            .overlay {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 50) {
                        Conversations_TextOnlyBubbleTypeView(
                            text: "Hello there 👋👋👋",
                            timestamp: "06:12 PM",
                            status: .random(),
                            userType: .receiver,
                            showPointer: true,
                            shouldAnimate: .random()
                        )
                        
                        Conversations_StickerOnlyBubbleTypeView(
                            url: .init(string: "https://user-images.githubusercontent.com/14011726/94132137-7d4fc100-fe7c-11ea-8512-69f90cb65e48.gif"),
                            timestamp: "10:44 PM",
                            userType: .receiver
                        )
                    }
                }
            }
    }
}

#Preview("Conversations_MessageThreadView") {
    Conversations_MessageThreadView()
}
