//
//  CustomSearchBar_PlaceholderTextView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-12.
//

import SwiftUI

struct CustomSearchBar_PlaceholderTextView: View {
    // MARK: - PROPERTIES
    let placeholder: String
    let text: String
    
    // MARK: - INITIALIZER
    init(placeholder: String, text: String) {
        self.placeholder = placeholder
        self.text = text
    }
    
    // MARK: - BODY
    var body: some View {
        Text(placeholder)
            .foregroundColor(.secondary)
            .opacity(text.isEmpty ? 1 : 0)
            .allowsHitTesting(false)
    }
}

//MARK: - PREVIEWS
#Preview("CustomSearchBar_PlaceholderTextView") {
    CustomSearchBar_PlaceholderTextView(placeholder: "Search", text: "")
        .previewViewModifier
}
