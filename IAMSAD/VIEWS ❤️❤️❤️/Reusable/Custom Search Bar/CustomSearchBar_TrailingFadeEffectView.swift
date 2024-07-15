//
//  CustomSearchBar_TrailingFadeEffectView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-13.
//

import SwiftUI

struct CustomSearchBar_TrailingFadeEffectView: View {
    // MARK: PROPERTIES
    @FocusState.Binding var isFocused: Bool
    
    // MARK: - BODY
    var body: some View {
        Color.searchBarBackground
            .frame(width: 35)
            .blur(radius: 1)
            .background(alignment: .trailing) { TrailingBackground_1() }
            .background(alignment: .trailing) { TrailingBackground_2() }
            .opacity(isFocused ? 0 : 1)
    }
}

// MARK: - PREVEIWS
#Preview("CustomSearchBar_TrailingFadeEffectView") {
    @Previewable @FocusState var isFocused: Bool
    CustomSearchBar_TrailingFadeEffectView(isFocused: $isFocused)
        .previewViewModifier
}

// MARK: - SUBVIEWS

// MARK: - TrailingBackground_1
fileprivate struct TrailingBackground_1: View {
    var body: some View {
        Color.searchBarBackground
            .frame(width: 62)
            .blur(radius: 10)
    }
}

// MARK: - TrailingBackground_2
fileprivate struct TrailingBackground_2: View {
    var body: some View {
        Color.searchBarBackground
            .frame(width: 30)
    }
}
