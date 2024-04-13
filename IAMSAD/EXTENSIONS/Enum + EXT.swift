//
//  Enum + EXT.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-13.
//

import Foundation

extension CaseIterable {
    // MARK: - random
    static func random() -> Self {
        let tempArray: [Self] = Array(Self.allCases)
        let randomIndex: Int = Int.random(in: 0...tempArray.count-1)
        
        return tempArray[randomIndex]
    }
}
