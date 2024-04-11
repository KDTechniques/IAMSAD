//
//  Conversations_StickerPlaceholderShapeView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-12.
//

import SwiftUI

struct Conversations_StickerPlaceholderShapeView: View {
    var body: some View {
        Conversations_StickerPlaceholderShape(45)
            .stroke(.primary.opacity(0.1), style: .init(lineWidth: 5, lineJoin: .round))
            .frame(width: 138, height: 138)
            .overlay {
                Conversations_StickerPlaceholderShape(45+2.5)
                    .fill(.primary.opacity(0.05))
                    .frame(width: 138 + 5, height: 138 + 5)
            }
            .overlay {
                Button {
                    print("Pressed!")
                } label: {
                    Circle()
                        .fill(.arrowDownCircle)
                        .padding(40)
                        .overlay {
                            Image(systemName: "arrow.down")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .fontWeight(.semibold)
                                .foregroundStyle(.arrowDown)
                        }
                }
            }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_StickerPlaceholderShape") {
    ZStack {
        Color.conversationBackground
            .ignoresSafeArea()
        
        Conversations_StickerPlaceholderShapeView()
    }
}

fileprivate struct Conversations_StickerPlaceholderShape: Shape {
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
            
            let value1: CGFloat = cornerRadius/65*50
            let value2: CGFloat = cornerRadius/65*70
            
            $0.addCurve(
                to: .init(x: rect.maxX - cornerRadius, y: rect.maxY),
                control1: .init(x: rect.maxX - value1, y: rect.maxY - value2),
                control2: .init(x: rect.maxX - value2, y: rect.maxY - value1)
            )
            
            $0.move(to: .init(x: rect.maxX, y: rect.maxY - cornerRadius))
            
            let value: CGFloat = cornerRadius/45*15
            
            $0.addQuadCurve(
                to: .init(x: rect.maxX - cornerRadius, y: rect.maxY),
                control: .init(x: rect.maxX-value, y: rect.maxY-value)
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
