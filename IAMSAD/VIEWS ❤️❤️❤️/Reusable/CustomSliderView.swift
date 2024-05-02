//
//  CustomSliderView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-02.
//

import SwiftUI

struct CustomSliderView: UIViewRepresentable {
    // MARK: - PROPERTIES
    @Binding var value: CGFloat
    @Binding var isThumbTouchDown: Bool
    @Binding var thumbSize: CGFloat
    
    let scale: CGFloat
    let minimumValueImage: String?
    let maximumValueImage: String?
    let thumbTintColor: UIColor?
    let minimumTrackTintColor: UIColor?
    let maximumTrackTintColor: UIColor?
    
    // MARK: - INITIALIZER
    init(
        value: Binding<CGFloat>,
        isThumbTouchDown: Binding<Bool> = .constant(false),
        thumbSize: Binding<CGFloat> = .constant(0),
        scale: CGFloat = 0.8,
        minimumValueImage: String? = nil,
        maximumValueImage: String? = nil,
        thumbTintColor: UIColor? = .white,
        minimumTrackTintColor: UIColor? = .accent,
        maximumTrackTintColor: UIColor? = .separator
    ) {
        self._value = value
        self._isThumbTouchDown = isThumbTouchDown
        self._thumbSize = thumbSize
        self.scale = scale
        self.minimumValueImage = minimumValueImage
        self.maximumValueImage = maximumValueImage
        self.thumbTintColor = thumbTintColor
        self.minimumTrackTintColor = minimumTrackTintColor
        self.maximumTrackTintColor = maximumTrackTintColor
    }
    
    // MARK: - makeUIView
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.sliderTouchDown),
            for: .touchDown
        )
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.sliderTouchUp),
            for: .touchUpInside
        )
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.sliderTouchUp),
            for: .touchUpOutside
        )
        
        slider.minimumValue = .zero
        slider.maximumValue = 1.0
        slider.value = Float(value)
        slider.isContinuous = true
        
        if let minimumValueImage, let maximumValueImage {
            slider.minimumValueImage = UIImage(systemName: minimumValueImage)
            slider.maximumValueImage = UIImage(systemName: maximumValueImage)
        }
        
        slider.minimumTrackTintColor = minimumTrackTintColor
        slider.maximumTrackTintColor = maximumTrackTintColor
        slider.thumbTintColor = thumbTintColor
        slider.layer.setAffineTransform(CGAffineTransform(scaleX: scale, y: scale))
        
        DispatchQueue.main.async {
            thumbSize = slider.currentThumbImage!.size.width*scale/2
        }
        
        return slider
    }
    
    // MARK: - updateUIView
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
    }
    
    // MARK: - makeCoordinator
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    // MARK: - Coordinator
    final class Coordinator: NSObject {
        var parent: CustomSliderView
        
        init(_ parent: CustomSliderView) {
            self.parent = parent
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            parent.value = Double(sender.value)
        }
        
        @objc func sliderTouchDown() {
            parent.isThumbTouchDown = true
        }
        
        @objc func sliderTouchUp() {
            parent.isThumbTouchDown = false
        }
    }
}

// MARK: - PREVIEWS
#Preview("value: .constant(0.75), scale: 1.0") {
    CustomSliderView(value: .constant(0.75), scale: 1.0)
        .previewViewModifier
}

#Preview("value: .constant(0.75)") {
    CustomSliderView(value: .constant(0.75))
        .previewViewModifier
}

#Preview("value: .constant(0.75), scale: 0.5") {
    CustomSliderView(value: .constant(0.75), scale: 0.5)
        .previewViewModifier
}
