//
//  CustomSearchBar_XButtonView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-13.
//

import SwiftUI

struct CustomSearchBar_XButtonView: View {
    // MARK: - PROPERTIES
    @Binding var text: String
    @FocusState.Binding var isFocused: Bool
    
    // MARK: - INITIALIZER
    init(text: Binding<String>, isFocused: FocusState<Bool>.Binding) {
        _text = text
        _isFocused = isFocused
    }
    
    // MARK: - BODY
    var body: some View {
        Button { handleTap() } label: {
            Image(systemName: "xmark.circle.fill")
                .symbolRenderingMode(.monochrome)
                .foregroundStyle(.searchBarIcons)
                .opacity(text.isEmpty ? 0 : 1)
                .padding(.trailing, 6)
                .animation(.none, value: text)
        }
    }
}

// MARK: - PREVIEWS
#Preview("CustomSearchBar_XButtonView") {
    @Previewable @FocusState var isFocused: Bool
    CustomSearchBar_XButtonView(text: .constant("123"), isFocused: $isFocused)
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension CustomSearchBar_XButtonView {
    // MARK: - handleTap
    private func handleTap() {
        text = ""
        isFocused = true
    }
}
