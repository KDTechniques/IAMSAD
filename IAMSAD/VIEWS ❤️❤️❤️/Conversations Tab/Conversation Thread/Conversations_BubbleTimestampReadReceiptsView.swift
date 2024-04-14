//
//  Conversations_BubbleTimestampReadReceiptsView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-13.
//

import SwiftUI

struct Conversations_BubbleTimestampReadReceiptsView: View {
    // MARK: - PROPERTIES
    let timestamp: String
    let status: ReadReceiptStatusTypes
    let shouldAnimate: Bool
    
    let values = MessageBubbleValues.self
    var hSpacing: CGFloat {
        values.timestampToReadReceiptPadding + (status == .pending ? 1 : 0)
    }
    
    // MARK: - INITIALIIZER
    init(timestamp: String, status: ReadReceiptStatusTypes, shouldAnimate: Bool) {
        self.timestamp = timestamp
        self.status = status
        self.shouldAnimate = shouldAnimate
    }
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: values.timestampToReadReceiptPadding) {
            Conversations_BubbleTimeStampView(timestamp)
            Conversations_ReadReceiptShapesView(status: status, shouldAnimate: shouldAnimate)
        }
        .padding(.bottom, -2)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_BubbleTimestampReadReceiptsView") {
    VStack {
        Conversations_BubbleTimestampReadReceiptsView(
            timestamp: "02:15 PM",
            status: .random(),
            shouldAnimate: .random()
        )
        
        Conversations_BubbleTimestampReadReceiptsView(
            timestamp: "02:15 PM",
            status: .pending,
            shouldAnimate: .random()
        )
    }
}
