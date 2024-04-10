//
//  Conversations_MessageThreadView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-09.
//

import SwiftUI

struct Conversations_MessageThreadView: View {
    
    var body: some View {
        Color.black.ignoresSafeArea()
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
                        ForEach(0...100, id: \.self) { index in
                            Conversations_TextOnlyBubbleTypeView(
                                text: "Hello there 👋👋👋",
                                timestamp: "06:12 PM",
                                userType: index % 2 == 0 ? .sender : .receiver,
                                showPointer: index % 2 == 0
                            )
                        }
                    }
                }
            }
    }
}

#Preview("Conversations_MessageThreadView") {
    Conversations_MessageThreadView()
}
