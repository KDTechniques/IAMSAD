//
//  Conversations_DocumentAudioPrimaryPlainBubble_InfoView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-06.
//

import SwiftUI

struct Conversations_DocumentAudioPrimaryPlainBubble_InfoView: View {
    // MARK: - PROPERTIES
    let direction: BubbleShapeValues.Directions
    let fileData: VoiceRecordNAudioBubbleValues.FileDataModel
    
    // MARK: - INITIALIZER
    init(direction: BubbleShapeValues.Directions,fileData: VoiceRecordNAudioBubbleValues.FileDataModel) {
        self.direction = direction
        self.fileData = fileData
    }
    
    // MARK: - PRIVATE PROPERTIES
    let values = VoiceRecordNAudioBubbleValues.self
    
    @State private var progressValue: CGFloat = 0
    @State private var showProgressIcon: Bool = false
    @State private var showProgressBar: Bool = false
    @State private var isExist: Bool = true
    @State private var percentage: Int = 0
    @State private var timeLeft: String = ""
    
    // MARK: - BODY
    var body: some View {
        HStack {
            fileIcon
            
            VStack(alignment: .leading) {
                fileName
                fileSizeNExtension
            }
            
            Conversations_DocumentAudioPrimaryPlainBubble_ProcessingView(
                direction: direction,
                progressValue: progressValue,
                showProgressIcon: showProgressIcon,
                showProgressBar: showProgressBar,
                isExist: isExist) { handleProgressTap() }
        }
        .padding(MessageBubbleValues.innerHPadding)
        .background(direction == .right ? .secondaryDocumentAudioBubbleSender : .secondaryDocumentAudioBubbleReceiver)
        .clipShape(CustomRoundedRectangleShape(cornerRadius: BubbleShapeValues.cornerRadius - MessageBubbleValues.secondaryOuterPadding.1))
        .padding(MessageBubbleValues.secondaryOuterPadding.0, MessageBubbleValues.secondaryOuterPadding.1)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_DocumentAudioPrimaryPlainBubble_InfoView") {
    BubbleVariator_Preview {
        Conversations_DocumentAudioPrimaryPlainBubble_InfoView(
            direction: $0 ? .left : .right,
            fileData: .init(
                fileURLString: "",
                fileName: "New Recording.m4a",
                fileSize: "56 KB",
                fileExtension: "m4a",
                duration: .zero
            )
        )
    }
}

// MARK: - EXTENSIONS
extension Conversations_DocumentAudioPrimaryPlainBubble_InfoView {
    // MARK: - fileIcon
    private var fileIcon: some View {
        Image(.file)
            .overlay {
                Text(fileData.fileExtension.uppercased())
                    .font(.system(size: 6, weight: .semibold))
                    .foregroundStyle(direction == .right ? .fileExtensionUpperCasedSender : .fileExtensionUpperCasedReceiver)
                    .offset(y: 1)
            }
    }
    
    // MARK: - fileName
    private var fileName: some View {
        Text(fileData.fileName)
            .foregroundStyle(direction == .right ? .fileNameSender : .fileNameReceiever)
    }
    
    // MARK: - fileSizeNExtension
    private var fileSizeNExtension: some View {
        Group {
            if showProgressBar, progressValue > 0 {
                Text("\(percentage)% (\(timeLeft) left) · \(fileData.fileSize)")
            } else {
                Text("\(fileData.fileSize) · \(fileData.fileExtension.lowercased())")
            }
        }
        .font(MessageBubbleValues.timestampFont)
        .foregroundStyle(.secondary)
        .lineLimit(1)
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - handleProgressTap
    private func handleProgressTap() {
        // code to handle downloading or uploading process
    }
}
