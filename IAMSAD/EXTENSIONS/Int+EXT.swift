//
//  Int+EXT.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-02.
//

import Foundation

extension Int {
    // MARK: - intToKMString
    func intToKMString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        
        if self > 999_000 || self >= 1_000_000 {
            let millions = Double(self) / 1_000_000.0
            return "\(formatter.string(from: NSNumber(value: millions)) ?? "")M"
        } else if self >= 1_000 {
            let thousands = Double(self) / 1_000.0
            return "\(formatter.string(from: NSNumber(value: thousands)) ?? "")K"
        } else { return "\(self)" }
    }
}
