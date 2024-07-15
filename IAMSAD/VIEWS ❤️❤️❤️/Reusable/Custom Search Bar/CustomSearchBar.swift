//
//  CustomSearchBar.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-12.
//

import SwiftUI

@MainActor
@Observable final class CustomSearchBar {
    // MARK: - PROPERTIES
    var searchBarTrailingPadding: CGFloat = 0
    var cancelButtonOffsetX: CGFloat = 55.0
    var cancelButtonOpacity: CGFloat = 0
    
    // MARK: - INITIALIZER
    public init() { }
    
    // MARK: - FUNCTIONS
    
    // MARK: - searchBarAnimation
    func searchBarAnimation(text: String, state: Bool) {
        if state || !text.isEmpty {
            withAnimation(.smooth(duration: 0.3)) {
                searchBarTrailingPadding = 65
                cancelButtonOffsetX = 48
                cancelButtonOpacity = 1
            }
        } else {
            withAnimation(.smooth(duration: 0.3)) {
                searchBarTrailingPadding = .zero
                cancelButtonOffsetX = 55
                cancelButtonOpacity = .zero
            }
        }
    }
}
