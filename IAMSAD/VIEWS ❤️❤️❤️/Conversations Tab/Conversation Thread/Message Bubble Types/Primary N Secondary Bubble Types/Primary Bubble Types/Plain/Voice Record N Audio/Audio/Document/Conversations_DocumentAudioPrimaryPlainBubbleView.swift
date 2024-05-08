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
    let fileData: VoiceRecordNAudioBubbleValues.FileDataModel
    let timestamp: String
    let status: ReadReceiptStatusTypes
    let shouldAnimate: Bool
    
    // MARK: - INITIALIZER
    init(
        direction: BubbleShapeValues.Directions,
        showPointer: Bool,
        fileData: VoiceRecordNAudioBubbleValues.FileDataModel,
        timestamp: String,
        status: ReadReceiptStatusTypes,
        shouldAnimate: Bool
    ) {
        self.direction = direction
        self.showPointer = showPointer
        self.fileData = fileData
        self.timestamp = timestamp
        self.status = status
        self.shouldAnimate = shouldAnimate
    }
    
    // MARK: - PRIVATE PROPERTIES
    
    
    // MARK: - BODY
    var body: some View {
        Conversations_MessageBubbleView(
            direction: direction,
            showPointer: showPointer
        ) {
            VStack(alignment: .trailing) {
                Conversations_DocumentAudioPrimaryPlainBubble_InfoView(direction: direction, fileData: fileData)
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
            direction: .left,
            showPointer: .random(),
            fileData: .init(
                fileURLString: "",
                fileName: "New Recording.m4a",
                fileSize: "12 KB",
                fileExtension: "m4a",
                duration: .zero
            ),
            timestamp: "12:45 PM",
            status: .random(),
            shouldAnimate: .random()
        )
    }
}

// MARK: - EXTENSIONS
extension Conversations_DocumentAudioPrimaryPlainBubbleView {
    // MARK: - bottomTrailingContent
    private var bottomTrailingContent: some View {
        Conversations_BubbleEditedTimestampReadReceiptsView(
            timestamp: timestamp,
            status: status,
            shouldAnimate: shouldAnimate
        )
        .padding(.trailing, MessageBubbleValues.innerHPadding)
    }
}
