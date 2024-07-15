//
//  CustomCountryCodeSearch_ListRowView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-14.
//

import SwiftUI

struct CustomCountryCodeSearch_ListRowView: View {
    // MARK: - PROPERTIES
    @Environment(CustomCountryCodeSearchViewModel.self) private var vm
    
    @Binding private var selectedCountryCode: PhoneNumberModel?
    @Binding private var isPresented: Bool
    let phoneNumbersArray: Array<PhoneNumberModel>.SubSequence
    
    
    // MARK: - INITIALIZER
    init(
        selectedCountryCode: Binding<PhoneNumberModel?>,
        isPresented: Binding<Bool>,
        phoneNumbersArray: Array<PhoneNumberModel>.SubSequence
    ) {
        _selectedCountryCode = selectedCountryCode
        _isPresented = isPresented
        self.phoneNumbersArray = phoneNumbersArray
    }
    
    // MARK: - BODY
    var body: some View {
        ForEach(phoneNumbersArray) { item in
            CustomCountryCodeSearch_ListRowItemView(
                selectedCountryCode: $selectedCountryCode,
                isPresented: $isPresented,
                item: item
            )
        }
    }
}

// MARK: - PREVIEWS
#Preview("CustomCountryCodeSearch_ListRowView") {
    @Previewable @State var selectedCountryCode: PhoneNumberModel?
    ScrollView(.vertical) {
        CustomCountryCodeSearch_ListRowView(
            selectedCountryCode: $selectedCountryCode,
            isPresented: .constant(false),
            phoneNumbersArray: CustomCountryCodeSearchViewModel().arrayByAlphabet.first!.1
        )
    }
    .previewViewModifier
}
