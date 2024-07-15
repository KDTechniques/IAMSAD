//
//  CustomCountryCodeSearch_ListRowItemView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-14.
//

import SwiftUI

struct CustomCountryCodeSearch_ListRowItemView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding private var selectedCountryCode: PhoneNumberModel?
    @Binding private var isPresented: Bool
    let item: PhoneNumberModel
    
    // MARK: - INITIALIZER
    init(
        selectedCountryCode: Binding<PhoneNumberModel?>,
        isPresented: Binding<Bool>,
        item: PhoneNumberModel
    ) {
        _selectedCountryCode = selectedCountryCode
        _isPresented = isPresented
        self.item = item
    }
    
    // MARK: - BODY
    var body: some View {
        HStack {
            TextView(item: item)
            Spacer()
            Image(systemName: "checkmark")
                .opacity(selectedCountryCode?.name == item.name ? 1 : 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(colorScheme == .dark
                    ? Color(uiColor: .systemGray6) /// default sheet color
                    : .white
        )
        .onTapGesture { onListRowTap(item: item) }
    }
}

// MARK: PREVIEWS
#Preview("CustomCountryCodeSearch_ListRowItemView") {
    @Previewable @State var selectedCountryCode: PhoneNumberModel?
    CustomCountryCodeSearch_ListRowItemView(
        selectedCountryCode: $selectedCountryCode,
        isPresented: .constant(false),
        item: .mockObject
    )
    .previewViewModifier
}

// MARK: - EXTENSIONS
extension CustomCountryCodeSearch_ListRowItemView {
    // MARK: - FUNCTIONS
    
    // MARK: - onListRowTap
    private func onListRowTap(item: PhoneNumberModel) {
        selectedCountryCode = item
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { isPresented = false }
    }
}

// MARK: - SUBVIEWS

// MARK: - TextView
fileprivate struct TextView: View {
    // MARK: - PROPERTIES
    let item: PhoneNumberModel
    
    // MARK: - INITIALIZER
    init(item: PhoneNumberModel) {
        self.item = item
    }
    
    // MARK: - BODY
    var body: some View {
        Text("\(item.flag) \(item.name) (\(item.dialCode))")
    }
}
