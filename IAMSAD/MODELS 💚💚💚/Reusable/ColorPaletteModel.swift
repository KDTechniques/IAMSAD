//
//  ColorPaletteModel.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-10.
//

import SwiftUI

struct ColorPaletteModel: Identifiable, Equatable {
    // MARK: - PROPERTIES
    var id                      : Double { hue }
    let hue                     : Double
    private(set) var saturation : Double
    private(set) var brightness : Double
    
    // MARK: - INITIALIZER
    init(hue: Double, saturation: Double, brightness: Double) {
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
    }
    
    // MARK: - FUNCTIONS
    mutating func changeColor(s: CGFloat, b: CGFloat) {
        self.saturation = s
        self.brightness = b
    }
}
