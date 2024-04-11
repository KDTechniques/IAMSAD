//
//  Conversations_BubbleShape.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-09.
//

import SwiftUI

struct Conversations_BubbleShape: Shape {
    // MARK: - PROPERTIES
    let direction: BubbleShapeValues.Directions
    let showPointer: Bool
    
    let values = BubbleShapeValues.self
    
    // MARK: - INITIALIZER
    init(direction: BubbleShapeValues.Directions, showPointer: Bool) {
        self.direction = direction
        self.showPointer = showPointer
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - path
    func path(in rect: CGRect) -> Path {
        if showPointer {
            direction == .left
            ? getLeftPointPath(in: rect).union(getLeftRectanglePath(in: rect))
            : getRightPointPath(in: rect).union(getRightRectanglePath(in: rect))
        } else {
            direction == .left
            ? getLeftRectanglePath(in: rect)
            : getRightRectanglePath(in: rect)
        }
    }
    
    // MARK: - getRightPointPath
    private func getRightPointPath(in rect: CGRect) -> Path {
        // safeTrailingX < maxX
        let safeTrailingX: CGFloat = rect.maxX - values.externalWidth
        
        return Path {
            $0.move(to: .init(
                x: safeTrailingX,
                y: rect.maxY - values.cornerRadius)
            )
            
            // outer curve
            $0.addQuadCurve(
                to: .init(x: rect.maxX, y: rect.maxY),
                control: .init(x: safeTrailingX, y: rect.maxY - 10*values.ratio)
            )
            
            // inner curve
            $0.addQuadCurve(
                to: .init(x: safeTrailingX - 15*values.ratio, y: rect.maxY - 8*values.ratio),
                control: .init(x: safeTrailingX - 5*values.ratio, y: rect.maxY)
            )
            
            $0.closeSubpath()
        }
    }
    
    // MARK: - getRightRectanglePath
    private func getRightRectanglePath(in rect: CGRect) -> Path {
        // safeTrailingX < maxX
        let safeTrailingX: CGFloat = rect.maxX - values.externalWidth
        
        return Path {
            $0.move(to: .zero)
            
            $0.addLine(to: .init(x: safeTrailingX - values.cornerRadius, y: rect.minY))
            
            // top trailing corner radius
            $0.addQuadCurve(
                to: .init(x: safeTrailingX, y: rect.minY + values.cornerRadius),
                control: .init(x: safeTrailingX, y: rect.minY)
            )
            
            $0.addLine(to: .init(x: safeTrailingX, y: rect.maxY - values.cornerRadius))
            
            // bottom trailing corner radius
            $0.addQuadCurve(
                to: .init(x: safeTrailingX - values.cornerRadius, y: rect.maxY),
                control: .init(x: safeTrailingX, y: rect.maxY)
            )
            
            $0.addLine(to: .init(x: rect.minX + values.cornerRadius, y: rect.maxY))
            
            // bottom leading corner radius
            $0.addQuadCurve(
                to: .init(x: rect.minX, y: rect.maxY - values.cornerRadius),
                control: .init(x: rect.minX, y: rect.maxY)
            )
            
            $0.addLine(to: .init(x: rect.minX, y: rect.minY + values.cornerRadius))
            
            // top leading corner radius
            $0.addQuadCurve(
                to: .init(x: rect.minX + values.cornerRadius, y: rect.minY),
                control: .init(x: rect.minX, y: rect.minY)
            )
            
            $0.closeSubpath()
        }
    }
    
    // MARK: - getLeftPointPath
    private func getLeftPointPath(in rect: CGRect) -> Path {
        // safeLeadingX > minX
        let safeLeadingX: CGFloat = rect.minX + values.externalWidth
        
        return Path {
            $0.move(to: .init(
                x: safeLeadingX,
                y: rect.maxY - values.cornerRadius)
            )
            
            // outer curve
            $0.addQuadCurve(
                to: .init(x: rect.minX, y: rect.maxY),
                control: .init(x: safeLeadingX, y: rect.maxY - 10*values.ratio)
            )
            
            // inner curve
            $0.addQuadCurve(
                to: .init(x: safeLeadingX + 15*values.ratio, y: rect.maxY - 8*values.ratio),
                control: .init(x: safeLeadingX + 5*values.ratio, y: rect.maxY)
            )
            
            $0.closeSubpath()
        }
    }
    
    // MARK: - getRightRectanglePath
    private func getLeftRectanglePath(in rect: CGRect) -> Path {
        // safeLeadingX > minX
        let safeLeadingX: CGFloat = rect.minX + values.externalWidth
        
        return Path {
            $0.move(to: .init(x: safeLeadingX, y: rect.minY))
            
            $0.addLine(to: .init(x: rect.maxX - values.cornerRadius, y: rect.minY))
            
            // top trailing corner radius
            $0.addQuadCurve(
                to: .init(x: rect.maxX, y: rect.minY + values.cornerRadius),
                control: .init(x: rect.maxX, y: rect.minY)
            )
            
            $0.addLine(to: .init(x: rect.maxX, y: rect.maxY - values.cornerRadius))
            
            // bottom trailing corner radius
            $0.addQuadCurve(
                to: .init(x: rect.maxX - values.cornerRadius, y: rect.maxY),
                control: .init(x: rect.maxX, y: rect.maxY)
            )
            
            $0.addLine(to: .init(x: safeLeadingX + values.cornerRadius, y: rect.maxY))
            
            // bottom leading corner radius
            $0.addQuadCurve(
                to: .init(x: safeLeadingX, y: rect.maxY - values.cornerRadius),
                control: .init(x: safeLeadingX, y: rect.maxY)
            )
            
            $0.addLine(to: .init(x: safeLeadingX, y: rect.minY + values.cornerRadius))
            
            // top leading corner radius
            $0.addQuadCurve(
                to: .init(x: safeLeadingX + values.cornerRadius, y: rect.minY),
                control: .init(x: safeLeadingX, y: rect.minY)
            )
            
            $0.closeSubpath()
            
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_BubbleShape - Right") {
    Conversations_BubbleShape(direction: .right, showPointer: Bool.random())
        .fill(Color.bubbleSender)
        .frame(width: 250, height: 100)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.trailing)
}

#Preview("Conversations_BubbleShape - Left") {
    Conversations_BubbleShape(direction: .left, showPointer: Bool.random())
        .fill(Color.bubbleSender)
        .frame(width: 250, height: 100)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)
}

// MARK: - OTHER

// MARK: - BubbleShapeValues
struct BubbleShapeValues {
    enum Directions {
        case left, right
        
        static func random() -> Self {
            Bool.random() ? .right : .left
        }
    }
    static let cornerRadius: CGFloat = 14
    static let eyeCraftedValue: CGFloat = 20
    static var ratio: CGFloat { cornerRadius/eyeCraftedValue }
    static var externalWidth: CGFloat { 8 * ratio }
}
