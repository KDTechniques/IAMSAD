//
//  CustomRoundedRectangleShape.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-10.
//

import SwiftUI

struct CustomRoundedRectangleShape: Shape {
    // MARK: - PROPERTIES
    let cornerRadius: CGFloat
    
    // MARK: - INITIALIER
    init(cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - path
    func path(in rect: CGRect) -> Path {
        Path {
            $0.move(to: .zero)
            
            $0.addLine(to: .init(x: rect.maxX - cornerRadius, y: rect.minY))
            
            // top trailing corner radius
            $0.addQuadCurve(
                to: .init(x: rect.maxX, y: rect.minY + cornerRadius),
                control: .init(x: rect.maxX, y: rect.minY)
            )
            
            $0.addLine(to: .init(x: rect.maxX, y: rect.maxY - cornerRadius))
            
            // bottom trailing corner radius
            $0.addQuadCurve(
                to: .init(x: rect.maxX - cornerRadius, y: rect.maxY),
                control: .init(x: rect.maxX, y: rect.maxY)
            )
            
            $0.addLine(to: .init(x: rect.minX + cornerRadius, y: rect.maxY))
            
            // bottom leading corner radius
            $0.addQuadCurve(
                to: .init(x: rect.minX, y: rect.maxY - cornerRadius),
                control: .init(x: rect.minX, y: rect.maxY)
            )
            
            $0.addLine(to: .init(x: rect.minX, y: rect.minY + cornerRadius))
            
            // top leading corner radius
            $0.addQuadCurve(
                to: .init(x: rect.minX + cornerRadius, y: rect.minY),
                control: .init(x: rect.minX, y: rect.minY)
            )
            
            $0.closeSubpath()
        }
    }
}

// MARK: - PREVIEWS
#Preview("CustomRoundedRectangleShape") {
    CustomRoundedRectangleShape(cornerRadius: 20)
        .fill(Color.debug)
        .frame(width: 250, height: 100)
}
