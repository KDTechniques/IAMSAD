//
//  CustomColorSliderView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-10.
//

import SwiftUI

struct CustomColorSliderView: View {
    // MARK: - PROPERTIES
    @Binding var color: ColorPaletteModel
    @Binding var sliderValue: CGFloat
    @Binding var sliderValueWithAnimation: CGFloat
    
    @State private var offsetX: CGFloat = 0
    @State private var sliderWidth: CGFloat = 0
    let thumbCircleWidth: CGFloat = 32
    let maxSliderValue: CGFloat = 0.5
    
    // MARK: - INITIALIZER
    init(
        sliderValue: Binding<CGFloat>,
        sliderValueWithAnimation: Binding<CGFloat>,
        color: Binding<ColorPaletteModel>
    ) {
        _sliderValue = sliderValue
        _sliderValueWithAnimation = sliderValueWithAnimation
        _color = color
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            SliderTrackView(sliderWidth: $sliderWidth, hue: color.hue)
            trackThumb
        }
    }
}

// MARK: - PREVIEWS
#Preview("CustomColorSliderView") {
    CustomColorSliderView(
        sliderValue: .constant(0.3),
        sliderValueWithAnimation: .constant(.zero),
        color: .constant(Color.defaultAvatarColorPaletteArray[2])
    )
    .previewViewModifier
}

#Preview("OnboardingAvatarView") {
    OnboardingAvatarView()
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension CustomColorSliderView {
    // MARK: - trackThumb
    private var trackThumb: some View {
        Circle()
            .fill(Color(
                hue: color.hue,
                saturation: color.saturation,
                brightness: color.brightness
            ))
            .frame(width: thumbCircleWidth)
            .background(
                Circle()
                    .stroke(.white, style: .init(
                        lineWidth: 3,
                        lineCap: .round,
                        lineJoin: .round
                    ))
            )
            .background(
                Circle()
                    .stroke(.black.opacity(0.1), style: .init(
                        lineWidth: 6,
                        lineCap: .round,
                        lineJoin: .round
                    ))
            )
            .offset(x: offsetX)
            .gesture(
                DragGesture()
                    .onChanged { onDragGestureChanged($0) }
                    .onEnded { onDragGestureEnded($0) }
            )
            .onChange(of: sliderValue) { setOffsetX($1) }
            .onChange(of: sliderValueWithAnimation) { setOffsetX($1, animate: true) }
            .onAppear { setOffsetX(sliderValue) }
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
            let roundedValue = tempSliderValue.rounded(toPlaces: 3)
            
            sliderValue = tempSliderValue
            color.changeColor(
                s: getSaturation(roundedValue),
                b: getBrightness(roundedValue)
            )
        }
    }
    
    // MARK: - onDragGestureEnded
    private func onDragGestureEnded(_ value: DragGesture.Value) {
        let maxOffsetX: CGFloat = sliderWidth/2 - thumbCircleWidth/2
        if abs(value.location.x) <= maxOffsetX {
            sliderValueWithAnimation = sliderValue
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
struct SliderTrackView: View {
    // MARK - PROPERTIES
    @Binding var sliderWidth: CGFloat
    let hue: CGFloat
    
    let sliderHeight: CGFloat = 14
    
    // MARK: - INITIALIZER
    init(sliderWidth: Binding<CGFloat>, hue: CGFloat) {
        _sliderWidth = sliderWidth
        self.hue = hue
    }
    
    // MARK: - BODY
    var body: some View {
        Capsule()
            .fill(Color.clear)
            .geometryReaderDimensionViewModifier($sliderWidth, dimension: .width)
            .background(
                LinearGradient(
                    colors: [
                        Color(hue: hue, saturation: 0.5, brightness: 1.0),
                        Color(hue: hue, saturation: 1.0, brightness: 1.0),
                        Color(hue: hue, saturation: 1.0, brightness: 0.5)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(Capsule())
            .background(
                Capsule()
                    .stroke(Color(uiColor: .systemGray4), style: .init(
                        lineWidth: 4,
                        lineCap: .round,
                        lineJoin: .round
                    ))
            )
            .frame(height: sliderHeight)
    }
}
