//
//  CustomSearchBarView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-16.
//

import SwiftUI

struct CustomSearchBarView: View {
    // MARK: - PROPERTIES
    @Binding var searchBarText: String
    let placeholder: String
    
    // MARK: - PRIVATE PROPERTIES
    @FocusState private var isFocused: Bool
    @State private var vm: CustomSearchBar = .init()
    
    // MARK: - INITIALIZER
    init(searchBarText: Binding<String>, placeholder: String) {
        _searchBarText = searchBarText
        self.placeholder = placeholder
    }
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 0) {
            CustomSearchBar_SearchIconView()
            
            CustomSearchBar_TextFieldView(
                text: $searchBarText,
                isFocused: $isFocused,
                placeholder: placeholder,
                vm: vm
            )
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 7)
        .overlay(alignment: .trailing) { trailingOverlay_1 }
        .overlay(alignment: .trailing) { trailingOverlay_2 }
        .background(.searchBarBackground)
        .clipShape(.rect(cornerRadius: 10))
        .padding(.horizontal)
        .overlay(alignment: .trailing) { trailingOverlay_3 }
        .padding(.trailing, vm.searchBarTrailingPadding)
    }
}

// MARK: - PREVIEWS
#Preview("CustomSearchBarView") {
    @Previewable @State var text: String = ""
    Color.clear
        .sheet(isPresented: .constant(true)) {
            VStack {
                CustomSearchBarView(
                    searchBarText: $text,
                    placeholder: "Search"
                )
                .padding(.top, 20)
                
                Spacer()
            }
            .presentationDragIndicator(.visible)
        }
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension CustomSearchBarView {
    // MARK: - trailingOverlay_1
    private var trailingOverlay_1: some View {
        CustomSearchBar_TrailingFadeEffectView(isFocused: $isFocused)
    }
    
    // MARK: - trailingOverlay_2
    private var trailingOverlay_2: some View {
        CustomSearchBar_XButtonView(text: $searchBarText, isFocused: $isFocused)
    }
    
    // MARK: - trailingOverlay_3
    private var trailingOverlay_3: some View {
        CustomSearchBar_CancelButtonView(
            text: $searchBarText,
            isFocused: $isFocused,
            vm: vm
        )
    }
}
