//
//  CustomColorSliderView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-10.
//

import SwiftUI

struct CustomColorSliderView: View {
    // MARK: - PROPERTIES
    @Environment(AvatarSheetVM.self) private var avatarSheetVM
    
    // MARK: - PRIVATE PROPERTIES
    @State private var offsetX: CGFloat = 0
    @State private var sliderWidth: CGFloat = 0
    
    let values = CustomColorSliderValues.self
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            SliderTrackView(
                sliderWidth: $sliderWidth,
                hue: avatarSheetVM.selectedBackgroundColor.hue
            )
            .onChange(of: avatarSheetVM.sliderValue) { setOffsetX($1) }
            .onChange(of: avatarSheetVM.sliderValueWithAnimation) { setOffsetX($1, animate: true) }
            .onAppear { setOffsetX(avatarSheetVM.sliderValue) }
            
            SliderTrackThumbView(sliderWidth: sliderWidth, offsetX: offsetX)
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
    // MARK: - FUNCTIONS
    
    // MARK: - setOffsetX
    private func setOffsetX(_ value: CGFloat, animate: Bool = false) {
        withAnimation(animate ? .default : .none) {
            offsetX = value * (sliderWidth/2 - values.thumbCircleWidth/2) / values.maxSliderValue
        }
    }
    
    
}
