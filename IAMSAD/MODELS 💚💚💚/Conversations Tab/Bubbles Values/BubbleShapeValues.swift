//
//  BubbleShapeValues.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-14.
//

import SwiftUI

struct BubbleShapeValues {
    enum Directions: CaseIterable {
        case left, right
    }
    
    static let cornerRadius: CGFloat = 14
    static var timestampOnlyCornerRadius: CGFloat { cornerRadius - 4 }
    static let eyeCraftedValue: CGFloat = 20
    static var ratio: CGFloat { cornerRadius/eyeCraftedValue }
    static var pointerWidth: CGFloat { 8 * ratio }
}
