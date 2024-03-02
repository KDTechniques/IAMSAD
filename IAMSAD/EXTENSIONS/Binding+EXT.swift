//
//  Binding+EXT.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-09.
//

import SwiftUI

extension Binding<String> {
    // MARK: - maxCharacters
    func maxCharacters(_ limit: Int) -> Self {
        DispatchQueue.main.async {
            self.wrappedValue = String(self.wrappedValue.prefix(limit))
        }
        
        return self
    }
}
