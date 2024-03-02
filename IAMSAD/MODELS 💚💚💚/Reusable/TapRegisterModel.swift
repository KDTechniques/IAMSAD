//
//  TapRegisterModel.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-01.
//

import Foundation

struct TapRegisterModel<T: Hashable>: Identifiable, Equatable {
    // MARK: - PROPERTIES
    let id: String = UUID().uuidString
    private(set) var frame: CGRect
    let event: T
    let action: ()->()
    
    // MARK: - INITIALIZER
    init(frame: CGRect, event: T, action: @escaping () -> Void) {
        self.frame = frame
        self.event = event
        self.action = action
    }
    
    // MARK: Equatable Confirmation
    static func == (lhs: TapRegisterModel<T>, rhs: TapRegisterModel<T>) -> Bool {
        lhs.frame == rhs.frame
    }
    
    
    // MARK: - FUNCTIONS
    mutating func setFrame(_ frame: CGRect) {
        self.frame = frame
    }
}
