//
//  CustomSearchBar_TextFieldView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-12.
//

import SwiftUI

struct CustomSearchBar_TextFieldView: View {
    // MARK: - PROPERTIES
    @Binding var text: String
    @FocusState.Binding var isFocused: Bool
    let placeholder: String
    let vm: CustomSearchBar
    
    // MARK: - INITIALIZER
    init(
        text: Binding<String>,
        isFocused: FocusState<Bool>.Binding,
        placeholder: String,
        vm: CustomSearchBar
    ) {
        _text = text
        _isFocused = isFocused
        self.placeholder = placeholder
        self.vm = vm
    }
    
    // MARK: - BODY
    var body: some View {
        TextField("", text: $text) { handleOnFocus($0) } onCommit: { handleOnCommit() }
            .focused($isFocused)
            .overlay(alignment: .leading) {
                CustomSearchBar_PlaceholderTextView(
                    placeholder: placeholder,
                    text: text
                )
            }
            .padding(.leading, 5)
            .padding(.trailing, isFocused ? 28 : 0)
    }
}

// MARK: - PREVIEWS
#Preview("CustomSearchBar_TextFieldView") {
    @Previewable @State var text: String = ""
    @Previewable @FocusState var isFocused: Bool
    CustomSearchBar_TextFieldView(
        text: $text,
        isFocused: $isFocused,
        placeholder: "Search",
        vm: .init()
    )
    .previewViewModifier
}

// MARK: - EXTENSIONS
extension CustomSearchBar_TextFieldView {
    // MARK: - FUNCTIONS
    
    // MARK: - handleOnFocus
    private func handleOnFocus(_ state: Bool) {
        vm.searchBarAnimation(text: text, state: state)
    }
    
    // MARK: - handleOnCommit
    private func handleOnCommit() {
        UIApplication.shared.endEditing(true)
    }
}
