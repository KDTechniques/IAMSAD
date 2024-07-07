//
//  Conversations_ReadReceiptShapes.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-13.
//

import SwiftUI

struct Conversations_ReadReceiptCheckmarkShapes: Shape {
    // MARK: - PROPERTIES
    let isFirstCheckmarkOnly: Bool
    let lineWidth: CGFloat
    let ratio: CGFloat
    
    // MARK: - INITIALIZER
    init(isFirstCheckmarkOnly: Bool, lineWidth: CGFloat, ratio: CGFloat) {
        self.isFirstCheckmarkOnly = isFirstCheckmarkOnly
        self.lineWidth = lineWidth
        self.ratio = ratio
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - path
    func path(in rect: CGRect) -> Path {
        isFirstCheckmarkOnly
        ? getFirstCheckmarkOnly(in: rect)
        : getBothCheckmarks(in: rect)
    }
    
    // MARK: - getFirstCheckmarkOnly
    private func getFirstCheckmarkOnly(in rect: CGRect) -> Path {
        Path {
            $0.move(to: CGPoint(x: rect.minX + lineWidth/3, y: rect.midY - (ratio*45)))
            
            $0.addLine(to: CGPoint(x: rect.minX + (ratio*130), y: rect.midY + (ratio*45)))
            
            $0.addLine(to: CGPoint(x: rect.midX + (ratio*95), y: rect.minY + lineWidth/2))
        }
    }
    
    // MARK: - getBothCheckmarks
    private func getBothCheckmarks(in rect: CGRect) -> Path {
        Path {
            $0.addPath(getFirstCheckmarkOnly(in: rect))
            
            $0.move(to: CGPoint(x: rect.midX - (ratio*50), y: rect.midY + (ratio*25)))
            
            $0.addLine(to: CGPoint(x: rect.midX, y: rect.midY + (ratio*62)))
            
            $0.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        }
    }
}

struct Conversations_ReadReceiptClockShape: Shape {
    // MARK: - PROPERTIES
    let lineWidth: CGFloat
    
    // MARK: - INITTIALIZER
    init(_ lineWidth: CGFloat) {
        self.lineWidth = lineWidth
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - path
    func path(in rect: CGRect) -> Path {
        var cornerRadius: CGFloat { rect.width / 2.8 }
        let strokeslessMinX: CGFloat = rect.minX + lineWidth/1.5
        let strokeslessMinY: CGFloat = rect.minY + lineWidth/2
        let strokeslessMaxX: CGFloat = rect.maxX - lineWidth/1.5
        let strokeslessMaxY: CGFloat = rect.maxY - lineWidth/2
        
        return Path {
            // MARK: - Frame
            $0.move(to: .init(x: strokeslessMinX + cornerRadius, y: strokeslessMinY))
            
            $0.addLine(to: .init(x: strokeslessMaxX - cornerRadius, y: strokeslessMinY))
            
            $0.addQuadCurve(
                to: .init(x: strokeslessMaxX, y: strokeslessMinY + cornerRadius),
                control: .init(x: strokeslessMaxX, y: strokeslessMinY)
            )
            
            $0.addLine(to: .init(x: strokeslessMaxX, y: strokeslessMaxY - cornerRadius))
            
            $0.addQuadCurve(
                to: .init(x: strokeslessMaxX - cornerRadius, y: strokeslessMaxY),
                control: .init(x: strokeslessMaxX, y: strokeslessMaxY)
            )
            
            $0.addLine(to: .init(x: strokeslessMinX + cornerRadius, y: strokeslessMaxY))
            
            $0.addQuadCurve(
                to: .init(x: strokeslessMinX, y: strokeslessMaxY - cornerRadius),
                control: .init(x: strokeslessMinX, y: strokeslessMaxY)
            )
            
            $0.addLine(to: .init(x: strokeslessMinX, y: strokeslessMinY + cornerRadius))
            
            $0.addQuadCurve(
                to: .init(x: strokeslessMinX + cornerRadius, y: strokeslessMinY),
                control: .init(x: strokeslessMinX, y: strokeslessMinY)
            )
            
            // MARK: - Weighted Hand
            let midY: CGFloat = rect.midY + lineWidth/1.5
            let midX: CGFloat = rect.midX - (lineWidth/2.5)
            let desiredCenterPoint: CGPoint = .init(x: midX, y: midY)
            
            $0.move(to: desiredCenterPoint)
            
            $0.addLine(to: .init(x: midX, y: midY - (cornerRadius/1.5)))
            
            $0.move(to: desiredCenterPoint)
            
            $0.addLine(to: .init(x: midX + (cornerRadius/2), y: midY))
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_ReadReceiptCheckmarkShapes") {
    Preview().previewViewModifier
}

#Preview("Conversations_ReadReceiptClockShape") {
    let values = ReadReceiptShapesValues(dynamicTypeSize: .large)
    
    return Conversations_ReadReceiptClockShape(values.lineWidth)
        .stroke(
            Color.secondary,
            style: .init(lineWidth: values.lineWidth, lineCap: .round, lineJoin: .round)
        )
        .frame(width: values.clipHeight, height: values.clipHeight)
        .previewViewModifier
}

// MARK: - Preview
fileprivate struct Preview: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    var values: ReadReceiptShapesValues { .init(dynamicTypeSize: dynamicTypeSize) }
    @State private var trimValue: CGFloat = 0
    @State private var isFirstCheckmarkOnly: Bool = true
    var body: some View {
        Conversations_ReadReceiptCheckmarkShapes(
            isFirstCheckmarkOnly: false,
            lineWidth: values.lineWidth,
            ratio: values.ratio
        )
        .trim(from: 0, to: isFirstCheckmarkOnly ? 1 : trimValue)
        .stroke(
            isFirstCheckmarkOnly ? Color.secondary : .accent,
            style: .init(lineWidth: values.lineWidth, lineCap: .round, lineJoin: .round)
        )
        .frame(width: values.size, height: values.size)
        .frame(height: values.clipHeight, alignment: .top)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                isFirstCheckmarkOnly = false
                withAnimation(values.animation) {
                    trimValue = 1
                }
            }
        }
    }
}
