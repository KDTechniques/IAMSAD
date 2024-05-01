//
//  Conversations_ReadReceiptShapesView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-13.
//

import SwiftUI

struct Conversations_ReadReceiptShapesView: View {
    // MARK: - PROPERTIES
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.colorScheme) private var colorScheme
    
    let status: ReadReceiptStatusTypes
    let shouldAnimate: Bool
    
    var values: ReadReceiptShapesValues { .init(dynamicTypeSize: dynamicTypeSize) }
    @State private var trimValue: CGFloat = 0
    var strokeColor: Color {
        status == .seen
        ? colorScheme == .dark ? .accent : .checkmarkSeenLight
        : MessageBubbleValues.specialSecondaryColor(colorScheme)
    }
    
    // MARK: - INITIALIZER
    init(status: ReadReceiptStatusTypes, shouldAnimate: Bool = false) {
        self.status = status
        self.shouldAnimate = shouldAnimate
    }
    
    // MARK: - BODY
    var body: some View {
        Group {
            if let bool = isFirstCheckmarkOnly(status) {
                checkmarks(bool)
            } else {
                clock
            }
        }
        .opacity(status == .none ? 0 : 1)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_ReadReceiptShapesView") {
    Conversations_ReadReceiptShapesView(status: .random(), shouldAnimate: .random())
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension Conversations_ReadReceiptShapesView {
    // MARK: - checkmarks
    private func checkmarks(_ bool: Bool) -> some View {
        Conversations_ReadReceiptCheckmarkShapes(
            isFirstCheckmarkOnly: bool,
            lineWidth: values.lineWidth,
            ratio: values.ratio
        )
        .trim(from: 0, to: status == .sent ? 1 : shouldAnimate ? trimValue : 1)
        .stroke(
            strokeColor,
            style: .init(lineWidth: values.lineWidth, lineCap: .round, lineJoin: .round)
        )
        .frame(width: values.size, height: values.size)
        .frame(height: values.clipHeight, alignment: .top)
        .onAppear { handleAnimation() }
    }
    
    // MARK: - clock
    @ViewBuilder
    private var clock: some View {
        let smoothFrameReductionValue: CGFloat = 0.5
        let smoothLineWidthReductionValue: CGFloat = 0.2
        let leadingPaddingRatio: CGFloat = values.clipHeight/5
        
        Conversations_ReadReceiptClockShape(values.lineWidth-smoothLineWidthReductionValue)
            .stroke(
                strokeColor,
                style: .init(lineWidth: values.lineWidth-smoothLineWidthReductionValue, lineCap: .round, lineJoin: .round)
            )
            .frame(
                width: values.clipHeight-smoothFrameReductionValue,
                height: values.clipHeight-smoothFrameReductionValue
            )
            .padding(.leading, leadingPaddingRatio)
            .frame(width: values.size, alignment: .leading)
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - isFirstCheckmarkOnly
    private func isFirstCheckmarkOnly(_ status: ReadReceiptStatusTypes) -> Bool? {
        switch status {
        case .sent:
            true
        case .delivered, .seen:
            false
        default:
            nil
        }
    }
    
    // MARK: - handleAnimation
    private func handleAnimation() {
        if status != .sent, shouldAnimate {
            withAnimation(values.animation) {
                trimValue = 1
            }
        }
    }
}
