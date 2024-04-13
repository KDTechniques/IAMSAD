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
    
    let status: ReadReceiptStatusTypes
    let shouldAnimate: Bool
    
    var values: ReadReceiptShapesValues { .init(dynamicTypeSize: dynamicTypeSize) }
    @State private var trimValue: CGFloat = 0
    
    // MARK: - INITIALIZER
    init(status: ReadReceiptStatusTypes, shouldAnimate: Bool = false) {
        self.status = status
        self.shouldAnimate = shouldAnimate
    }
    
    // MARK: - BODY
    var body: some View {
        if let bool = isFirstCheckmarkOnly(status) {
            Conversations_ReadReceiptCheckmarkShapes(
                isFirstCheckmarkOnly: bool,
                lineWidth: values.lineWidth,
                ratio: values.ratio
            )
            .trim(from: 0, to: status == .sent ? 1 : shouldAnimate ? trimValue : 1)
            .stroke(
                status == .seen ? .accent : Color.secondary,
                style: .init(lineWidth: values.lineWidth, lineCap: .round)
            )
            .frame(width: values.size, height: values.size)
            .frame(height: values.clipHeight, alignment: .top)
            .onAppear { handleAnimation() }
        } else {
            let smoothFrameReductionValue: CGFloat = 0.5
            let smoothLineWidthReductionValue: CGFloat = 0.2
            
            Conversations_ReadReceiptClockShape(values.lineWidth-smoothLineWidthReductionValue)
                .stroke(
                    Color.secondary,
                    style: .init(lineWidth: values.lineWidth-smoothLineWidthReductionValue, lineCap: .round)
                )
                .frame(
                    width: values.clipHeight-smoothFrameReductionValue,
                    height: values.clipHeight-smoothFrameReductionValue
                )
                .padding(.leading, values.clipHeight/5)
                .frame(width: values.size, alignment: .leading)
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_ReadReceiptShapesView") {
    Conversations_ReadReceiptShapesView(status: .random(), shouldAnimate: .random())
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension Conversations_ReadReceiptShapesView {
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
