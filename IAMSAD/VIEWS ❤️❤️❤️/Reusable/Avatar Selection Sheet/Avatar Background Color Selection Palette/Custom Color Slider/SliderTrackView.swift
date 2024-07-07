//
//  SliderTrackView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-06-27.
//

import SwiftUI

struct SliderTrackView: View {
    // MARK - PROPERTIES
    @Binding var sliderWidth: CGFloat
    let hue: CGFloat
    
    // MARK: - PRIVATE PROPERTIES
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

// MARK: - PREVIEWS
#Preview("SliderTrackView") {
    SliderTrackView(sliderWidth: .constant(.zero), hue: .random(in: 0...1))
        .padding(.horizontal)
        .previewViewModifier
}
