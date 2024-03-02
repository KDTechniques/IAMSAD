//
//  CGFloat+EXT.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-29.
//

import Foundation

extension CGFloat {
    // MARK: - rounded
    func rounded(toPlaces places: Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(places))
        return (self * divisor).rounded() / divisor
    }
}
