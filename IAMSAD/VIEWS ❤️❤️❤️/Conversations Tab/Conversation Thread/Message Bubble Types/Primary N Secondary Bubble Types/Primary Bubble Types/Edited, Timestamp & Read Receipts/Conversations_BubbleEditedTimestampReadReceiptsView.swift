//
//  Conversations_BubbleEditedTimestampReadReceiptsView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-13.
//

import SwiftUI

struct Conversations_BubbleEditedTimestampReadReceiptsView: View {
    // MARK: - PROPERTIES
    let model: MessageBubbleValues.MessageBubbleModel
    
    let values = MessageBubbleValues.self
    var hSpacing: CGFloat {
        values.editedToTimestampToReadReceiptSpacing + (model.status == .pending ? 1 : 0)
    }
    
    // MARK: - INITIALIIZER
    init(_ model: MessageBubbleValues.MessageBubbleModel) {
        self.model = model
    }
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: values.editedToTimestampToReadReceiptSpacing) {
            if model.isEdited {
                Conversations_EditedTextView()
                    .padding(.trailing, values.editedToTimestampTrailingPadding)
            }
            
            Conversations_BubbleTimeStampView(model.timestamp)
            
            if model.status != .none, model.direction == .right {
                Conversations_ReadReceiptShapesView(
                    status: model.status,
                    shouldAnimate: model.shouldAnimate
                )
            }
        }
        .padding(.bottom, -2)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_BubbleEditedTimestampReadReceiptsView") {
    VStack(alignment: .trailing) {
        Conversations_BubbleEditedTimestampReadReceiptsView(.init(
            direction: .right,
            showPointer: .random(),
            timestamp: "06:27 AM",
            status: .sent
        ))
        
        Conversations_BubbleEditedTimestampReadReceiptsView(.init(
            direction: .right,
            showPointer: .random(),
            timestamp: "11:15 PM",
            status: .pending
        ))
        
        Conversations_BubbleEditedTimestampReadReceiptsView(.getRandomMockObject(false, true))
    }
}
