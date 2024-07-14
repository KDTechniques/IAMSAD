//
//  CustomCountryCodeSearchSheetView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-14.
//

import SwiftUI

struct CustomCountryCodeSearchSheetView: View {
    // MARK: - PROPERTIES
    @Binding private var isPresented: Bool
    @Binding private var selectedCountryCode: PhoneNumberModel?
    
    // MARK: - PRIVATE PROPERTIES
    @State private var vm: CustomCountryCodeSearchViewModel = .init()
    
    // MARK: - INITILIZER
    init(isPresented: Binding<Bool>, selectedCountryCode: Binding<PhoneNumberModel?>) {
        _isPresented            = isPresented
        _selectedCountryCode    = selectedCountryCode
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 20) {
            CustomSearchBarView(
                searchBarText: $vm.searchText,
                placeholder: "Your country"
            )
            
            CustomCountryCodeSearch_ListBuilderView(
                selectedCountryCode: $selectedCountryCode,
                isPresented: $isPresented
            )
        }
        .padding(.top, 20)
        .environment(vm)
    }
}

// MARK: - PREVIEWS
#Preview("CustomCountryCodeSearchSheetView") {
    @Previewable @State var selectedCountryCode: PhoneNumberModel?
    Color.clear
        .sheet(isPresented: .constant(true)) {
            CustomCountryCodeSearchSheetView(
                isPresented: .constant(true),
                selectedCountryCode: $selectedCountryCode
            )
            .presentationDragIndicator(.visible)
        }
        .previewViewModifier
}
