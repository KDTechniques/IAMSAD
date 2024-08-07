//
//  CustomCountryCodeSearch_ListBuilderView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-14.
//

import SwiftUI

struct CustomCountryCodeSearch_ListBuilderView: View {
    // MARK: - PROPERTIES
    @Environment(CustomCountryCodeSearchViewModel.self) private var vm
    
    @Binding private var selectedCountryCode: PhoneNumberModel?
    @Binding private var isPresented: Bool
    
    // MARK: - INITIALIZER
    init(selectedCountryCode: Binding<PhoneNumberModel?>, isPresented: Binding<Bool>) {
        _selectedCountryCode = selectedCountryCode
        _isPresented = isPresented
    }
    
    // MARK: - BODY
    var body: some View {
        Group {
            switch vm.state {
            case .noResults: noResultsText
            default: CustomCountryCodeSearch_ListView(
                selectedCountryCode: $selectedCountryCode,
                isPresented: $isPresented
            )}
        }
        .listStyle(.plain)
    }
}

// MARK: - PREVIEWS
#Preview("CustomCountryCodeSearch_ListBuilderView") {
    @Previewable @State var selectedCountryCode: PhoneNumberModel?
    Color.clear
        .sheet(isPresented: .constant(true)) {
            CustomCountryCodeSearch_ListBuilderView(
                selectedCountryCode: $selectedCountryCode,
                isPresented: .constant(false)
            )
        }
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension CustomCountryCodeSearch_ListBuilderView {
    // MARK: - noResultsText
    private var noResultsText: some View {
        CustomContentNotAvailableView(title: "No Results")
            .frame(maxHeight: .infinity)
    }
}
