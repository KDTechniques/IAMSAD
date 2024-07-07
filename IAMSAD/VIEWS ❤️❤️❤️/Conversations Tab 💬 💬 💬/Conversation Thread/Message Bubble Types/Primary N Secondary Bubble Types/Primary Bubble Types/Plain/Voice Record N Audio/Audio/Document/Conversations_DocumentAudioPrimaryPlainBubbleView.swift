//
//  Conversations_DocumentAudioPrimaryPlainBubbleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-06.
//

import SwiftUI

struct Conversations_DocumentAudioPrimaryPlainBubbleView: View {
    // MARK: - PROPERTIES
    let model: MessageBubbleValues.MessageBubbleModel
    let fileData: VoiceRecordNAudioBubbleValues.FileDataModel
    
    // MARK: - INITIALIZER
    init(
        model: MessageBubbleValues.MessageBubbleModel,
        fileData: VoiceRecordNAudioBubbleValues.FileDataModel
    ) {
        self.model = model
        self.fileData = fileData
    }
    
    // MARK: - BODY
    var body: some View {
        Conversations_MessageBubbleView(model) {
            VStack(alignment: .trailing) {
                Conversations_DocumentAudioPrimaryPlainBubble_InfoView(
                    direction: model.direction,
                    fileData: fileData
                )
                
                bottomTrailingContent
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
            model: .getRandomMockObject(true),
            fileData: .getRandomObject()
        )
    }
}

// MARK: - EXTENSIONS
extension Conversations_DocumentAudioPrimaryPlainBubbleView {
    // MARK: - bottomTrailingContent
    private var bottomTrailingContent: some View {
        Conversations_BubbleEditedTimestampReadReceiptsView(model)
            .padding(.trailing, MessageBubbleValues.innerHPadding)
    }
}
