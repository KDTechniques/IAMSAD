//
//  Conversations_ReadReceiptShapes.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-13.
//

import SwiftUI

struct Conversations_ReadReceiptShapes: Shape {
    // MARK: - PROPERTIES
    let size: CGFloat
    let lineWidth: CGFloat
    var ratio: CGFloat { size/578 }
    
    // MARK: - FUNCTIONS
    func path(in rect: CGRect) -> Path {
        Path {
            // MARK: - First Checkmark
            $0.move(to: .init(x: rect.midX + (ratio*95), y: rect.minY + lineWidth))
            
            $0.addLine(to: .init(x: rect.minX + (ratio*130), y: rect.midY + (ratio*62)))
            
            $0.addLine(to: .init(x: rect.minX + lineWidth, y: rect.midY - (ratio*15)))
            
            // MARK: - Second Checkmark
            $0.move(to: .init(x: rect.maxX - lineWidth, y: rect.minY + lineWidth))
            
            $0.addLine(to: .init(x: rect.midX, y: rect.midY + (ratio*62)))
            
            $0.addLine(to: .init(x: rect.midX - (ratio*50), y: rect.midY + (ratio*25)))
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_ReadReceiptShapes") {
    let size: CGFloat = 15
    let lineWidth: CGFloat = 1.2
    
    return Conversations_ReadReceiptShapes(size: size, lineWidth: lineWidth)
        .stroke(.accent, style: .init(lineWidth: lineWidth, lineCap: .round))
        .frame(width: size, height: size)
}
