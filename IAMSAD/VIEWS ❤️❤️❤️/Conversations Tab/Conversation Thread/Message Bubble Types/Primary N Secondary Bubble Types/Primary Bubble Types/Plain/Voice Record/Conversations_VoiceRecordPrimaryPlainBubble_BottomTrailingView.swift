//
//  Conversations_VoiceRecordPrimaryPlainBubble_BottomTrailingView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-03.
//

import SwiftUI

struct Conversations_VoiceRecordPrimaryPlainBubble_BottomTrailingView: View {
    // MARK: - PROPERTIES
    let width: CGFloat
    let fileSize: String
    let duration: String
    let type: VoiceRecordBubbleValues.FileDatatypes
    let timestamp: String
    let status: ReadReceiptStatusTypes
    let shouldAnimate: Bool
    
    // MARK: - INITIALIZER
    init(
        width: CGFloat,
        fileSize: String,
        duration: String,
        type: VoiceRecordBubbleValues.FileDatatypes,
        timestamp: String,
        status: ReadReceiptStatusTypes,
        shouldAnimate: Bool
    ) {
        self.width = width
        self.fileSize = fileSize
        self.duration = duration
        self.type = type
        self.timestamp = timestamp
        self.status = status
        self.shouldAnimate = shouldAnimate
    }
    
    // MARK: - PRIVATE PROPERTIES
    let values = MessageBubbleValues.self
    let voiceRecordValues = VoiceRecordBubbleValues.self
    
    // MARK: - BODY
    var body: some View {
        HStack {
            fileSizeOrDuration
            Spacer()
            timeStampNReadReceipts
        }
        .frame(width: width)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_VoiceRecordPrimaryPlainBubble_BottomTrailingView") {
    Conversations_VoiceRecordPrimaryPlainBubble_BottomTrailingView(
        width: 170,
        fileSize: "19 KB",
        duration: "0:05",
        type: .duration,
        timestamp: "12:15 PM",
        status: .seen,
        shouldAnimate: false
    )
}

// MARK: - EXTENSIONS
extension Conversations_VoiceRecordPrimaryPlainBubble_BottomTrailingView {
    //MARK: - fileSizeOrDuration
    private var fileSizeOrDuration: some View {
        Text(type == .fileSize ? fileSize : duration)
            .font(values.timestampFont)
            .foregroundStyle(.secondary)
            .padding(.bottom, values.bottomTrailingContentBottomPadding)
    }
    
    // MARK: - timeStampNReadReceipts
    private var timeStampNReadReceipts: some View {
        Conversations_BubbleEditedTimestampReadReceiptsView(
            timestamp: timestamp,
            status: status,
            shouldAnimate: shouldAnimate
        )
    }
}
