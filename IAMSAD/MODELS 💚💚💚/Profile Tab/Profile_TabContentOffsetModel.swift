//
//  Profile_TabContentOffsetModel.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-13.
//

import Foundation

struct Profile_TabContentOffsetModel: Identifiable {
    // MARK: - PROPERTIES
    let id: String = UUID().uuidString
    let tab: Profile_TabLabelTypes
    private(set) var offsetY: CGFloat?
    
    // MARK: - INITIALIZER
    init(tab: Profile_TabLabelTypes) {
        self.tab = tab
        self.offsetY = 0
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - setOffsetY
    mutating func setOffsetY(_ offsetY: CGFloat) {
        self.offsetY = offsetY
    }
    
    // MARK: - setToNil
    mutating func setToNil() {
        self.offsetY = nil
    }
}
