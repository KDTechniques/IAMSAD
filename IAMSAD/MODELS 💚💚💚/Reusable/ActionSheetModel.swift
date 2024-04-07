//
//  ActionSheetModel.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-07.
//

import SwiftUI

struct ActionSheetModel<T: View>: Identifiable {
    // MARK: - PROPERTIES
    let id: String = UUID().uuidString
    let content: T
    
    // MARK: - INITIALIZER
    init(_ content: T) {
        self.content = content
    }
}
