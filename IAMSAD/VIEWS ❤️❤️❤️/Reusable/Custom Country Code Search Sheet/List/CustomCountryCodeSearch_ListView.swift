//
//  CustomCountryCodeSearch_ListView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-15.
//

import SwiftUI

struct CustomCountryCodeSearch_ListView: View {
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
        List {
            ForEach(vm.arrayByAlphabet, id: \.0) { char, phoneNumbersArray in
                Section(char?.description ?? "") {
                    CustomCountryCodeSearch_ListRowView(
                        selectedCountryCode: $selectedCountryCode,
                        isPresented: $isPresented,
                        phoneNumbersArray: phoneNumbersArray
                    )
                }
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("CustomCountryCodeSearch_ListView") {
    @Previewable @State var selectedCountryCode: PhoneNumberModel?
    CustomCountryCodeSearch_ListView(
        selectedCountryCode: $selectedCountryCode,
        isPresented: .constant(false)
    )
    .previewViewModifier
}
