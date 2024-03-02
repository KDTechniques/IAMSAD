//
//  Color+EXT.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-09.
//

import SwiftUI

extension Color {
    // MARK: - debug
    static var debug: Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        
        return Color(red: red, green: green, blue: blue)
    }
    
    // MARK: - defaultAvatarColorPaletteArray
    static let defaultAvatarColorPaletteArray: [ColorPaletteModel] = [
        .init(hue: 0.00, saturation: 0.5, brightness: 1.0), // 1
        .init(hue: 0.06, saturation: 0.5, brightness: 1.0), // 2
        .init(hue: 0.10, saturation: 0.5, brightness: 1.0), // 3
        .init(hue: 0.14, saturation: 0.5, brightness: 1.0), // 4
        .init(hue: 0.20, saturation: 0.5, brightness: 1.0), // 5
        .init(hue: 0.32, saturation: 0.5, brightness: 1.0), // 6
        .init(hue: 0.49, saturation: 0.5, brightness: 1.0), // 7
        .init(hue: 0.58, saturation: 0.5, brightness: 1.0), // 8
        .init(hue: 0.65, saturation: 0.5, brightness: 1.0), // 9
        .init(hue: 0.74, saturation: 0.5, brightness: 1.0), // 10
        .init(hue: 0.84, saturation: 0.5, brightness: 1.0), // 11
        .init(hue: 0.92, saturation: 0.5, brightness: 1.0)  // 12
    ]
}
