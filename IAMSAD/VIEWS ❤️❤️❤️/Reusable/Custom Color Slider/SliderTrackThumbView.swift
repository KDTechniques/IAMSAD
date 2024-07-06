//
//  SliderTrackThumbView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-06.
//

import SwiftUI

struct SliderTrackThumbView: View {
    // MARK: - PRORPERTIES
    @Environment(AvatarSheetVM.self) private var vm
    
    let sliderWidth: CGFloat
    let offsetX: CGFloat
    
    // MARK: - PRIVATE PROPERTIES
    let values = CustomColorSliderValues.self
    
    // MARK: - INITITLAIZER
    init(sliderWidth: CGFloat, offsetX: CGFloat) {
        self.sliderWidth = sliderWidth
        self.offsetX = offsetX
    }
    
    // MARK: - BODY
    var body: some View {
        Circle()
            .fill(Color(
                hue: vm.selectedBackgroundColor.hue,
                saturation: vm.selectedBackgroundColor.saturation,
                brightness: vm.selectedBackgroundColor.brightness
            ))
            .frame(width: values.thumbCircleWidth)
            .background(BackgroundView1())
            .background(BackgroundView2())
            .offset(x: offsetX)
            .gesture(
                DragGesture()
                    .onChanged { onDragGestureChanged($0) }
                    .onEnded { onDragGestureEnded($0) }
            )
    }
}

// MARK: - PREVIEWS
#Preview("Preview") {
    SliderTrackThumbView(sliderWidth: 0, offsetX: 0)
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension SliderTrackThumbView {
    // MARK: - onDragGestureChanged
    private func onDragGestureChanged(_ value: DragGesture.Value) {
        let maxOffsetX: CGFloat = sliderWidth/2 - values.thumbCircleWidth/2
        if abs(value.location.x) <= maxOffsetX {
            let tempSliderValue = value.location.x * values.maxSliderValue / maxOffsetX
            
            vm.sliderValue = tempSliderValue
            
            vm.selectedBackgroundColor.changeColor(
                s: getSaturation(tempSliderValue),
                b: getBrightness(tempSliderValue)
            )
        }
    }
    
    // MARK: - onDragGestureEnded
    private func onDragGestureEnded(_ value: DragGesture.Value) {
        let maxOffsetX: CGFloat = sliderWidth/2 - values.thumbCircleWidth/2
        
        if abs(value.location.x) <= maxOffsetX {
            vm.sliderValueWithAnimation = vm.sliderValue
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
