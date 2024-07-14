//
//  CustomSearchBar_CancelButtonView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-13.
//

import SwiftUI

struct CustomSearchBar_CancelButtonView: View {
    // MARK: - PROPERTIES
    @Binding var text: String
    @FocusState.Binding var isFocused: Bool
    let vm: CustomSearchBar
    
    // MARK: - INITIALIZER
    init(text: Binding<String>, isFocused: FocusState<Bool>.Binding, vm: CustomSearchBar) {
        _text = text
        _isFocused = isFocused
        self.vm = vm
    }
    
    // MARK: - BODY
    var body: some View {
        Button { handleTap() } label: { Text("Cancel") }
            .offset(x: vm.cancelButtonOffsetX)
            .opacity(vm.cancelButtonOpacity)
    }
}

// MARK: - PREVIEWS
#Preview("CustomSearchBar_CancelButtonView") {
    @Previewable @FocusState var isFocused: Bool
    let vm: CustomSearchBar = .init()
    
    CustomSearchBar_CancelButtonView(
        text: .constant("123"),
        isFocused: $isFocused,
        vm: vm
    )
    .previewViewModifier
    .onAppear {
        vm.cancelButtonOpacity = 1.0
    }
}

// MARK: - EXTENSIONS
extension CustomSearchBar_CancelButtonView {
    // MARK: - FUNCTIONS
    
    // MARK: - handleTap
    private func handleTap() {
        text = ""
        vm.searchBarAnimation(text: text, state: false)
        isFocused = false
    }
}
