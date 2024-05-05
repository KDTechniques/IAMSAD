//
//  ReadReceiptShapesValues.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-14.
//

import SwiftUI

struct ReadReceiptShapesValues {
    // MARK: - PROPERTIES
    let dynamicTypeSize: DynamicTypeSize
    
    var size: CGFloat {
        "".heightOfHString(
            usingFont: .from(.footnote),
            dynamicTypeSize
        )
    }
    let lineWidth: CGFloat = 1.4
    var ratio: CGFloat { size/578 }
    /// don't simplify the clipHeight  by adding 1/2 or 0.5
    var clipHeight: CGFloat {
        (size - (size/2) + (ratio*62)) + lineWidth
    }
    let animation: Animation = .linear(duration: 0.15)
    
    
    // MARK: - INITIALIZER
    init(dynamicTypeSize: DynamicTypeSize) {
        self.dynamicTypeSize = dynamicTypeSize
    }
}
