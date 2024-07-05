//
//  CustomColorSliderView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-10.
//

import SwiftUI

struct CustomColorSliderView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var avatarSheetVM: AvatarSheetVM
    
    // MARK: - PRIVATE PROPERTIES
    @State private var offsetX: CGFloat = 0
    @State private var sliderWidth: CGFloat = 0
    
    let thumbCircleWidth: CGFloat = 32
    let maxSliderValue: CGFloat = 0.5
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            sliderTrack
            trackThumb
        }
    }
}

// MARK: - PREVIEWS
#Preview("CustomColorSliderView") {
    CustomColorSliderView()
        .padding(.horizontal)
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension CustomColorSliderView {
    // MARK: - sliderTrack
    private var sliderTrack: some View {
        SliderTrackView(
            sliderWidth: $sliderWidth,
            hue: avatarSheetVM.selectedBackgroundColor.hue
        )
        .onChange(of: avatarSheetVM.sliderValue) { setOffsetX($1) }
        .onChange(of: avatarSheetVM.sliderValueWithAnimation) { setOffsetX($1, animate: true) }
        .onAppear { setOffsetX(avatarSheetVM.sliderValue) }
    }
    
    // MARK: - trackThumb
    private var trackThumb: some View {
        Circle()
            .fill(Color(
                hue: avatarSheetVM.selectedBackgroundColor.hue,
                saturation: avatarSheetVM.selectedBackgroundColor.saturation,
                brightness: avatarSheetVM.selectedBackgroundColor.brightness
            ))
            .frame(width: thumbCircleWidth)
            .background(BackgroundView1())
            .background(BackgroundView2())
            .offset(x: offsetX)
            .gesture(
                DragGesture()
                    .onChanged { onDragGestureChanged($0) }
                    .onEnded { onDragGestureEnded($0) }
            )
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - setOffsetX
    private func setOffsetX(_ value: CGFloat, animate: Bool = false) {
        withAnimation(animate ? .default : .none) {
            offsetX = value * (sliderWidth/2 - thumbCircleWidth/2) / maxSliderValue
        }
    }
    
    // MARK: - onDragGestureChanged
    private func onDragGestureChanged(_ value: DragGesture.Value) {
        let maxOffsetX: CGFloat = sliderWidth/2 - thumbCircleWidth/2
        if abs(value.location.x) <= maxOffsetX {
            let tempSliderValue = value.location.x * maxSliderValue / maxOffsetX
            
            avatarSheetVM.sliderValue = tempSliderValue
            
            avatarSheetVM.selectedBackgroundColor.changeColor(
                s: getSaturation(tempSliderValue),
                b: getBrightness(tempSliderValue)
            )
        }
    }
    
    // MARK: - onDragGestureEnded
    private func onDragGestureEnded(_ value: DragGesture.Value) {
        let maxOffsetX: CGFloat = sliderWidth/2 - thumbCircleWidth/2
        
        if abs(value.location.x) <= maxOffsetX {
            avatarSheetVM.sliderValueWithAnimation = avatarSheetVM.sliderValue
        }
    }
    
    // MARK: - getSaturation
    private func getSaturation(_ sliderValue: CGFloat) -> CGFloat {
        (sliderValue < .zero ? 1.0 - abs(sliderValue) : 1.0).rounded(toPlaces: 3)
    }
    
    // MARK: - getSaturation
    private func getBrightness(_ sliderValue: CGFloat) -> CGFloat {
        (sliderValue > .zero ? 1.0 - sliderValue : 1.0).rounded(toPlaces: 3)
    }
}

// MARK: - SUBVIEWS

// MARK: - BackgroundView1
fileprivate struct BackgroundView1: View {
    var body: some View {
        Circle()
            .stroke(.white, style: .init(
                lineWidth: 3,
                lineCap: .round,
                lineJoin: .round
            ))
    }
}

// MARK: - BackgroundView2
fileprivate struct BackgroundView2: View {
    var body: some View {
        Circle()
            .stroke(.black.opacity(0.1), style: .init(
                lineWidth: 6,
                lineCap: .round,
                lineJoin: .round
            ))
    }
}
