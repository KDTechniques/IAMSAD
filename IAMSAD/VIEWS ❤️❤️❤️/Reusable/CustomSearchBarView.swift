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
    
    @FocusState private var isFocused: Bool
    @State private var searchBarTrailingPadding: CGFloat = 0
    @State private var cancelButtonOffsetX: CGFloat = 55.0
    @State private var cancelButtonOpacity: CGFloat = 0
    
    // MARK: - INITIALIZER
    init(searchBarText: Binding<String>, placeholder: String) {
        _searchBarText = searchBarText
        self.placeholder = placeholder
    }
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 0) {
            searchIcon
            textField
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 7)
        .overlay(alignment: .trailing) { trailingFade }
        .overlay(alignment: .trailing) { xButton }
        .background(.searchBarBackground)
        .clipShape(.rect(cornerRadius: 10))
        .padding(.horizontal)
        .overlay(alignment: .trailing) { cancelButton }
        .padding(.trailing, searchBarTrailingPadding)
    }
}

// MARK: - PREVIEWS
#Preview("CustomSearchBarView") {
    CustomSearchBarView(
        searchBarText: .constant("1234567890"),
        placeholder: "Placeholder"
    )
    .previewViewModifier
}

// MARK: - EXTENSION
extension CustomSearchBarView {
    // MARK: - searchIcon
    private var searchIcon: some View {
        Image(systemName: "magnifyingglass")
            .foregroundColor(.searchBarIcons)
    }
    
    // MARK: - textField
    private var textField: some View {
        TextField("", text: $searchBarText) {
            searchBarAnimation($0)
        } onCommit: { UIApplication.shared.endEditing(true) }
            .focused($isFocused)
            .overlay(alignment: .leading) { placeholderText }
            .padding(.leading, 5)
            .padding(.trailing, isFocused ? 28 : 0)
    }
    
    // MARK: - placeholderText
    private var placeholderText: some View {
        Text(placeholder)
            .foregroundColor(.secondary)
            .opacity(searchBarText.isEmpty ? 1 : 0)
            .allowsHitTesting(false)
    }
    
    // MARK: - trailingFade
    private var trailingFade: some View {
        Color.searchBarBackground
            .frame(width: 35)
            .blur(radius: 1)
            .background(alignment: .trailing) {
                Color.searchBarBackground
                    .frame(width: 62)
                    .blur(radius: 10)
            }
            .background(alignment: .trailing) {
                Color.searchBarBackground
                    .frame(width: 30)
            }
            .opacity(isFocused ? 0 : 1)
    }
    
    // MARK: - xButton
    private var xButton: some View {
        Button { handleXButtonTap() } label: {
            Image(systemName: "xmark.circle.fill")
                .symbolRenderingMode(.monochrome)
                .foregroundStyle(.searchBarIcons)
                .opacity(searchBarText.isEmpty ? 0 : 1)
                .padding(.trailing, 6)
                .animation(.none, value: searchBarText)
        }
    }
    
    // MARK: - cancelButton
    private var cancelButton: some View {
        Button {
            searchBarText = ""
            searchBarAnimation(false)
            isFocused = false
        } label: {
            Text("Cancel")
            
        }
        .offset(x: cancelButtonOffsetX)
        .opacity(cancelButtonOpacity)
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - handleXButtonTap
    private func handleXButtonTap() {
        searchBarText = ""
        isFocused = true
    }
    
    // MARK: - searchBarAnimation
    private func searchBarAnimation(_ state: Bool) {
        if state || !searchBarText.isEmpty {
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
