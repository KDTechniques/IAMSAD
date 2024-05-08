//
//  Conversations_VoiceRecordNAudioPrimaryPlainBubble_BottomTrailingView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-03.
//

import SwiftUI
import CoreMedia

struct Conversations_VoiceRecordNAudioPrimaryPlainBubble_BottomTrailingView: View {
    // MARK: - PROPERTIES
    let width: CGFloat?
    let fileSize: String
    let duration: CMTime
    let type: VoiceRecordNAudioBubbleValues.FileDatatypes
    let timestamp: String
    let status: ReadReceiptStatusTypes
    let shouldAnimate: Bool
    
    // MARK: - INITIALIZER
    init(
        width: CGFloat? = nil,
        fileSize: String,
        duration: CMTime,
        type: VoiceRecordNAudioBubbleValues.FileDatatypes,
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
    let voiceRecordValues = VoiceRecordNAudioBubbleValues.self
    
    // MARK: - BODY
    var body: some View {
        HStack {
            fileSizeOrDuration
            Spacer()
            timeStampNReadReceipts
        }
        .setWidth(width)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_VoiceRecordNAudioPrimaryPlainBubble_BottomTrailingView") {
    Conversations_VoiceRecordNAudioPrimaryPlainBubble_BottomTrailingView(
        width: VoiceRecordNAudioBubbleValues.actualSpectrumWidth,
        fileSize: "19 KB",
        duration: .zero,
        type: .random(),
        timestamp: "12:15 PM",
        status: .random(),
        shouldAnimate: .random()
    )
}

// MARK: - EXTENSIONS
extension Conversations_VoiceRecordNAudioPrimaryPlainBubble_BottomTrailingView {
    //MARK: - fileSizeOrDuration
    private var fileSizeOrDuration: some View {
        Text(type == .fileSize ? fileSize : duration.asString())
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

extension View {
    // MARK: - setWidth
    @ViewBuilder
    fileprivate func setWidth(_ width: CGFloat? = nil) -> some View {
        if let width: CGFloat {
            self
        } else {
            self.frame(width: width)
        }
    }
}
