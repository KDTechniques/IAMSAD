//
//  CustomColorSliderView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-10.
//

import SwiftUI

struct CustomColorSliderView: View {
    // MARK: - PROPERTIES
    @Environment(AvatarSheetVM.self) private var vm
    
    // MARK: - PRIVATE PROPERTIES
    @State private var offsetX: CGFloat = 0
    @State private var sliderWidth: CGFloat = 0
    
    let values = CustomColorSliderValues.self
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            SliderTrackView(
                sliderWidth: $sliderWidth,
                hue: vm.selectedBackgroundColor.hue
            )
            .onChange(of: vm.sliderValue) { setOffsetX($1) }
            .onChange(of: vm.sliderValueWithAnimation) { setOffsetX($1, animate: true) }
            .onAppear { setOffsetX(vm.sliderValue) }
            
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
