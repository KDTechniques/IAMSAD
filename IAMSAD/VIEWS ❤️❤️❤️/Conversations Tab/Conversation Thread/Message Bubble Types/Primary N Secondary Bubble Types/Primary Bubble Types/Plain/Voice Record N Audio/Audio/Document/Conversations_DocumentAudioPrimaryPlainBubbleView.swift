//
//  Conversations_DocumentAudioPrimaryPlainBubbleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-06.
//

import SwiftUI

struct Conversations_DocumentAudioPrimaryPlainBubbleView: View {
    // MARK: - PROPERTIES
    let direction: BubbleShapeValues.Directions
    let showPointer: Bool
    
    // MARK: - INITIALIZER
    
    
    // MARK: - PRIVATE PROPERTIES
    
    
    // MARK: - BODY
    var body: some View {
        Conversations_MessageBubbleView(
            direction: direction,
            showPointer: showPointer
        ) {
            VStack(alignment: .trailing) {
                HStack {
                    Image(.file)
                        .overlay {
                            Text("M4A")
                                .font(.system(size: 6, weight: .semibold))
                                .foregroundStyle(.secondary)
                                .offset(y: 1)
                        }
                    
                    VStack(alignment: .leading) {
                        Text("New Recording 2.m4a")
                            .foregroundStyle(Color(uiColor: .darkGray))
                        
                        Text("23 KB · m4a")
                            .font(MessageBubbleValues.timestampFont)
                            .foregroundStyle(.secondary)
                    }
                    
                    
                }
                .padding(10)
                .background(.primary.opacity(0.08))
                .clipShape(CustomRoundedRectangleShape(cornerRadius: BubbleShapeValues.cornerRadius - MessageBubbleValues.secondaryOuterPadding.1))
                .padding(MessageBubbleValues.secondaryOuterPadding.0, MessageBubbleValues.secondaryOuterPadding.1)
                
                Conversations_BubbleEditedTimestampReadReceiptsView(
                    timestamp: "12:16 PM",
                    status: .seen,
                    shouldAnimate: .random()
                )
                .padding(.trailing, MessageBubbleValues.innerHPadding)
            }
            .padding(.bottom, MessageBubbleValues.innerVPadding)
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_DocumentAudioPrimaryPlainBubbleView") {
    ZStack {
        Color.conversationBackground
            .ignoresSafeArea()
        
        Conversations_DocumentAudioPrimaryPlainBubbleView(
            direction: .right,
            showPointer: .random()
        )
    }
}
