//
//  Conversations_StickerPlaceholderShape.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-12.
//

import SwiftUI

struct Conversations_StickerPlaceholderShape: Shape {
    // MARK: - PROPERTIES
    let cornerRadius: CGFloat
    
    // MARK: - INITIALIZER
    init(_ cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - path
    func path(in rect: CGRect) -> Path {
        Path {
            $0.move(to: .init(x: rect.minX + cornerRadius, y: rect.minY))
            
            $0.addLine(to: .init(x: rect.maxX - cornerRadius, y: rect.minY))
            
            $0.addQuadCurve(
                to: .init(x: rect.maxX, y: rect.minY + cornerRadius),
                control: .init(x: rect.maxX, y: rect.minY)
            )
            
            $0.addLine(to: .init(x: rect.maxX, y: rect.maxY - cornerRadius))
            
            let value1: CGFloat = cornerRadius/65*60
            
            $0.addCurve(
                to: .init(x: rect.maxX - cornerRadius, y: rect.maxY),
                control1: .init(x: rect.maxX - value1, y: rect.maxY - value1),
                control2: .init(x: rect.maxX - value1, y: rect.maxY - value1)
            )
            
            $0.move(to: .init(x: rect.maxX, y: rect.maxY - cornerRadius))
            
            let value2: CGFloat = cornerRadius/45*12
            
            $0.addQuadCurve(
                to: .init(x: rect.maxX - cornerRadius, y: rect.maxY),
                control: .init(x: rect.maxX - value2, y: rect.maxY-value2)
            )
            
            $0.addLine(to: .init(x: rect.minX + cornerRadius, y: rect.maxY))
            
            $0.addQuadCurve(
                to: .init(x: rect.minX, y: rect.maxY - cornerRadius),
                control: .init(x: rect.minX, y: rect.maxY)
            )
            
            $0.addLine(to: .init(x: rect.minX, y: rect.minY + cornerRadius))
            
            $0.addQuadCurve(
                to: .init(x: rect.minX + cornerRadius, y: rect.minY),
                control: .init(x: rect.minX, y: rect.minY)
            )
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_StickerPlaceholderShape - Stroke Only") {
    let values = MessageBubbleValues.self
    return Conversations_StickerPlaceholderShape(45)
        .stroke(.red, style: .init(lineWidth: 5, lineJoin: .round))
        .frame(width: values.stickerFrameSize, height: values.stickerFrameSize)
}

#Preview("Conversations_StickerPlaceholderShape - Fill & Stroke") {
    let values = MessageBubbleValues.self
    return Conversations_StickerPlaceholderShape(45)
        .fill(.red)
        .stroke(.black, style: .init(lineWidth: 5, lineJoin: .round))
        .frame(width: values.stickerFrameSize, height: values.stickerFrameSize)
}
