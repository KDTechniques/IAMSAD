//
//  String+EXT.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-02.
//

import Foundation

extension String {
    // MARK: - kmStringToInt
    func kmStringToInt() -> Int? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        if let number = formatter.number(from: self) {
            return number.intValue
        } else if self.hasSuffix("K"), let number = formatter.number(from: String(self.dropLast())) {
            return Int(number.doubleValue * 1000)
        } else if self.hasSuffix("M"), let number = formatter.number(from: String(self.dropLast())) {
            return Int(number.doubleValue * 1_000_000)
        } else { return nil // Invalid input string }
        }
    }
    
    // MARK: - truncateToLineLimit
    func truncateToLineLimit(lineLimit: Int, dotsLimit: Int) -> String {
        var truncatedString: String = ""
        let lines: Array<String>.SubSequence = self.components(separatedBy: "\n").prefix(lineLimit)
        
        if lines.count >= dotsLimit {
            return self
        }
        
        for line in lines {
            truncatedString += line.trimmingCharacters(in: .whitespacesAndNewlines)
            if line != lines.last {
                truncatedString += "\n"
            }
        }
        
        return truncatedString
    }
}
