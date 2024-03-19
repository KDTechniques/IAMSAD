//
//  Utilities.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-19.
//

import SwiftUI

actor Utilities {
    // MARK: - getCharactersArray
    func getCharactersArray() -> [String] {
        let aScalars: String.UnicodeScalarView = "a".unicodeScalars
        let aCode: UInt32 = aScalars[aScalars.startIndex].value
        let characters: [String] = (0..<26).map {
            Character(UnicodeScalar(aCode + $0)!).uppercased()
        }
        
        return characters
    }
}
