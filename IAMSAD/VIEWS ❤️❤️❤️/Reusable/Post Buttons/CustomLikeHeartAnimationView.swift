//
//  CustomLikeHeartAnimationView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-01.
//

import SwiftUI

struct CustomLikeHeartAnimationView: View {
    // MARK: - PROPERTIES
    let like: Bool
    let size: CGFloat
    let backgroundViewColor: Color
    
    // primaryHeartImage
    let primaryHeartImageSize: CGFloat = 40
    @State private var primaryHeartImageOpacity: CGFloat = 1
    @State private var primaryHeartImageScaleEffect: CGFloat = 1
    
    // primaryCircle
    @State private var primaryCircleRadius: CGFloat = 0
    let maxPrimaryCircleRadius: CGFloat = 40
    
    // secondaryCircle
    @State private var secondaryCircleSize: CGFloat = 0
    
    // secondaryHeartImage
    @State private var secondaryHeartImageSize: CGFloat = 4
    @State private var secondaryHeartImageOpacity: CGFloat = 0
    
    // invisibleCircle1
    @State private var invisibleCircle1Radius: CGFloat = 28
    
    // invisibleCircle2
    @State private var invisibleCircle2Radius: CGFloat = 23
    
    // tinyBubbles
    let tinyBubblesSize: CGFloat = 5
    @State private var tinyBubblesOpacity: CGFloat = 0
    @State private var tinyBubble1ScaleEffect: CGFloat = 1
    @State private var tinyBubble2ScaleEffect: CGFloat = 1
    
    let angle: CGFloat = 360/7
    let frameSize: CGFloat = 150
    
    // MARK: - INITIALIZER
    init(like: Bool, size: CGFloat, backgroundViewColor: Color) {
        self.like = like
        self.size = size
        self.backgroundViewColor = backgroundViewColor
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            primaryHeartImage
            invisibleCircle1
            invisibleCircle2
            primaryCircle
            secondaryCircle
            secondaryHeartImage
        }
        .frame(width: frameSize, height: frameSize)
        .scaleEffect(size/frameSize)
        .frame(width: size, height: size)
        .clipShape(Rectangle())
        .onAppear { handleOnAppear() }
        .onChange(of: like) { oldValue, newValue in
            animate(newValue)
        }
    }
}

// MARK: - PREVIEWS
#Preview("CustomLikeHeartAnimationView") {
    @Previewable @State var like: Bool = false
    
    CustomLikeHeartAnimationView(like: like, size: 255, backgroundViewColor: .colorScheme)
        .onTapGesture { like.toggle() }
}

// MARK: - EXTENSIONS
extension CustomLikeHeartAnimationView {
    // MARK: - heartImage
    private var primaryHeartImage: some View {
        Image(systemName: "heart")
            .resizable()
            .scaledToFill()
            .frame(
                width: primaryHeartImageSize,
                height: primaryHeartImageSize
            )
            .foregroundStyle(.secondary)
            .opacity(primaryHeartImageOpacity)
            .scaleEffect(primaryHeartImageScaleEffect)
    }
    
    // MARK: - PrimaryCircle
    private var primaryCircle: some View {
        Circle()
            .fill(Color(
                hue: 0.9,
                saturation: 0.7 - (primaryCircleRadius/100),
                brightness: 1
            ))
            .frame(
                width: 2 * primaryCircleRadius,
                height: 2 * primaryCircleRadius
            )
    }
    
    // MARK: - SecondaryCircle
    private var secondaryCircle: some View {
        Circle()
            .fill(Color(backgroundViewColor))
            .frame(width: secondaryCircleSize, height: secondaryCircleSize)
    }
    
    // MARK: - secondaryHeartImage
    private var secondaryHeartImage: some View {
        Image(systemName: "heart.fill")
            .resizable()
            .scaledToFill()
            .frame(width: secondaryHeartImageSize, height: secondaryHeartImageSize)
            .foregroundStyle(.heartIconNText)
            .opacity(secondaryHeartImageOpacity)
    }
    
    // MARK: - invisibleCircle1
    private var invisibleCircle1: some View {
        Circle()
            .fill(.clear)
            .frame(width: 2 * invisibleCircle1Radius, height: 2 * invisibleCircle1Radius)
            .overlay {
                ForEach(1...7, id: \.self) {
                    Circle()
                        .fill(Color.debug)
                        .frame(width: tinyBubblesSize, height: tinyBubblesSize)
                        .scaleEffect(tinyBubble1ScaleEffect)
                        .position(
                            x: invisibleCircle1Radius + invisibleCircle1Radius * cos(degreesToRadians(angle * CGFloat($0))),
                            y: invisibleCircle1Radius + invisibleCircle1Radius * sin(degreesToRadians(angle * CGFloat($0)))
                        )
                }
                .rotationEffect(.degrees(angle - 90))
                .opacity(tinyBubblesOpacity)
            }
    }
    
    // MARK: - invisibleCircle2
    private var invisibleCircle2: some View {
        Circle()
            .fill(.clear)
            .frame(
                width: 2 * invisibleCircle2Radius,
                height: 2 * invisibleCircle2Radius
            )
            .overlay {
                ForEach(1...7, id: \.self) {
                    Circle()
                        .fill(Color.debug)
                        .frame(width: tinyBubblesSize, height: tinyBubblesSize)
                        .scaleEffect(tinyBubble2ScaleEffect)
                        .position(
                            x: invisibleCircle2Radius + invisibleCircle2Radius * cos(degreesToRadians(angle * CGFloat($0))),
                            y: invisibleCircle2Radius + invisibleCircle2Radius * sin(degreesToRadians(angle * CGFloat($0)))
                        )
                }
                .rotationEffect(.degrees(20))
                .opacity(tinyBubblesOpacity)
            }
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - degreesToRadians
    private func degreesToRadians(_ degrees: Double) -> CGFloat {
        CGFloat(degrees * .pi / 180.0)
    }
    
    // MARK: - toggle
    private func animate(_ like: Bool) {
        HapticFeedbackGenerator().vibrate(type: .medium)
        
        if like {
            primaryHeartImageOpacity = 0
            
            withAnimation(.smooth(duration: 0.5)) {
                primaryCircleRadius = maxPrimaryCircleRadius
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.smooth(duration: 0.5)) {
                    secondaryCircleSize = (2 * maxPrimaryCircleRadius) + 2
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.03) {
                    
                    tinyBubblesOpacity = 1
                    
                    withAnimation(.bouncy(duration: 1, extraBounce: 0.2)) {
                        secondaryHeartImageSize = primaryHeartImageSize
                    }
                    
                    withAnimation(.smooth(duration: 0.3)) {
                        invisibleCircle1Radius = maxPrimaryCircleRadius + 5
                        invisibleCircle2Radius = maxPrimaryCircleRadius + 18
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
                        secondaryHeartImageOpacity = 1
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.smooth(duration: 0.2)) {
                        tinyBubble1ScaleEffect = 0
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.smooth(duration: 0.5)) {
                            tinyBubble2ScaleEffect = 0
                            primaryCircleRadius = 0
                            secondaryCircleSize = 0
                        }
                    }
                }
            }
        } else { reset() }
    }
    
    // MARK: - reset
    private func reset() {
        primaryCircleRadius = .zero
        secondaryCircleSize = .zero
        invisibleCircle1Radius = 28
        invisibleCircle2Radius = 23
        tinyBubblesOpacity = .zero
        tinyBubble1ScaleEffect = 1
        tinyBubble2ScaleEffect = 1
        secondaryHeartImageOpacity = .zero
        secondaryHeartImageSize = 4
        
        primaryHeartImageOpacity = 1
        withAnimation(.bouncy(duration: 0.3, extraBounce: 0.1)) {
            primaryHeartImageScaleEffect = 1.5
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation(.bouncy(duration: 0.3, extraBounce: 0.1)) {
                primaryHeartImageScaleEffect = 1
            }
        }
    }
    
    // MARK: - handleOnAppear
    private func handleOnAppear() {
        primaryHeartImageOpacity = like ? 0 : 1
        secondaryHeartImageSize = primaryHeartImageSize
        secondaryHeartImageOpacity = like ? 1 : 0
    }
}
