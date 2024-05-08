//
//  CustomCircularProgressBarView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-07.
//

import SwiftUI

struct CustomCircularProgressBarView: View {
    // MARK: - PROPERTIES
    // Circle
    let value: CGFloat
    let circleStrokeColor: Color
    let progressStrokeColor: Color
    let strokeWidth: CGFloat
    let circleSize: CGFloat?
    
    // Stop - Rounded Rectangle
    let stopRectangleColor: Color
    let stopRectanglePadding: CGFloat
    let cornerRadius: CGFloat
    
    // MARK: - INITIALIZER
    init(
        value: CGFloat,
        circleStrokeColor: Color,
        progressStrokeColor: Color,
        strokeWidth: CGFloat,
        circleSize: CGFloat? = nil,
        stopRectangleColor: Color,
        stopRectanglePadding: CGFloat,
        cornerRadius: CGFloat,
        scale: CGFloat = 1.0
    ) {
        self.value = value
        self.circleStrokeColor = circleStrokeColor
        self.progressStrokeColor = progressStrokeColor
        self.strokeWidth = strokeWidth * scale
        self.circleSize = circleSize != nil ? circleSize! * scale : circleSize
        self.stopRectangleColor = stopRectangleColor
        self.stopRectanglePadding = stopRectanglePadding * scale
        self.cornerRadius = cornerRadius * scale
    }
    
    // MARK: - PRIVATE PROPERTIES
    var progressStrokeWidth: CGFloat { strokeWidth + 0.2 }
    
    // MARK: - BODY
    var body: some View {
        Circle()
            .stroke(circleStrokeColor, lineWidth: strokeWidth)
            .setCircleFrame(circleSize)
            .overlay {
                Circle()
                    .trim(from: 0, to: value)
                    .stroke(progressStrokeColor, style: .init(lineWidth: progressStrokeWidth, lineCap: .round))
                    .rotationEffect(.degrees(-90))
            }
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(stopRectangleColor)
                    .padding(stopRectanglePadding)
            }
    }
}

// MARK: - PREVIEWS
#Preview("CustomCircularProgressBarView") {
    CustomCircularProgressBarView(
        value: CGFloat.random(in: 0...1),
        circleStrokeColor: .init(uiColor: .systemGray6),
        progressStrokeColor: .accentColor,
        strokeWidth: 2,
        circleSize: VoiceRecordNAudioBubbleValues.actionIconsFrameWidth + 10,
        stopRectangleColor: .accent,
        stopRectanglePadding: 8.6,
        cornerRadius: 1
    )
}

// MARK: - EXTENSIONS
extension View {
    // MARK: - setCircleFrame
    @ViewBuilder
    fileprivate func setCircleFrame(_ size: CGFloat?) -> some View {
        if let size: CGFloat {
            self.frame(width: size, height: size)
        } else {
            self
        }
    }
}
