//
//  Conversations_BubbleEditedTimestampReadReceiptsView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-13.
//

import SwiftUI

struct Conversations_BubbleEditedTimestampReadReceiptsView: View {
    // MARK: - PROPERTIES
    let isEdited: Bool
    let timestamp: String
    let status: ReadReceiptStatusTypes
    let shouldAnimate: Bool
    
    let values = MessageBubbleValues.self
    var hSpacing: CGFloat {
        values.editedToTimestampToReadReceiptSpacing + (status == .pending ? 1 : 0)
    }
    
    // MARK: - INITIALIIZER
    init(
        isEdited: Bool = false,
        timestamp: String,
        status: ReadReceiptStatusTypes,
        shouldAnimate: Bool
    ) {
        self.isEdited = isEdited
        self.timestamp = timestamp
        self.status = status
        self.shouldAnimate = shouldAnimate
    }
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: values.editedToTimestampToReadReceiptSpacing) {
            if isEdited {
                Conversations_EditedTextView()
                    .padding(.trailing, values.editedToTimestampTrailingPadding)
            }
            
            Conversations_BubbleTimeStampView(timestamp)
            
            if status != .none {
                Conversations_ReadReceiptShapesView(status: status, shouldAnimate: shouldAnimate)
            }
        }
        .padding(.bottom, -2)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_BubbleEditedTimestampReadReceiptsView") {
    VStack(alignment: .trailing) {
        Conversations_BubbleEditedTimestampReadReceiptsView(
            timestamp: "06:27 AM",
            status: .random(),
            shouldAnimate: .random()
        )
        
        Conversations_BubbleEditedTimestampReadReceiptsView(
            timestamp: "11:15 PM",
            status: .pending,
            shouldAnimate: .random()
        )
        
        Conversations_BubbleEditedTimestampReadReceiptsView(
            isEdited: true,
            timestamp: "02:05 PM",
            status: .random(),
            shouldAnimate: .random()
        )
    }
}
