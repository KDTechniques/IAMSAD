//
//  CustomCountryCodeSearchSheetView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-14.
//

import SwiftUI
import Algorithms

struct CustomCountryCodeSearchSheetView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding private var isPresented: Bool
    @Binding private var selectedCountryCode: PhoneNumberModel?
    
    @State private var searchText: String = ""
    @State private var filteredCountryCodePhoneNumbersArray: [PhoneNumberModel] = []
    @State private var state: StateTypes = .defaultArray
    let countryCodePhoneNumbersArray: [PhoneNumberModel] = PhoneNumberModel
        .getCountryPhoneNumbersArray()?
        .sorted(by: { $0.name < $1.name }) ?? []
    
    // MARK: - INITILIZER
    init(isPresented: Binding<Bool>, selectedCountryCode: Binding<PhoneNumberModel?>) {
        _isPresented            = isPresented
        _selectedCountryCode    = selectedCountryCode
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            CustomSearchBarView(
                searchBarText: $searchText,
                placeholder: "Your country"
            )
            .padding(.bottom, 11)
            
            list
        }
        .padding(.top, 20)
        .onChange(of: searchText) { filterResults(text: $1) }
    }
}

// MARK: - PREVIEWS
#Preview("CustomCountryCodeSearchSheetView") {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            CustomCountryCodeSearchSheetView(
                isPresented: .constant(true),
                selectedCountryCode: .constant(.mockObject)
            )
            .presentationDragIndicator(.visible)
        }
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension CustomCountryCodeSearchSheetView {
    // MARK: - StateTypes
    enum StateTypes {
        case defaultArray, filteredArray, noResults
    }
    
    // MARK: - list
    private var list: some View {
        Group {
            switch state {
            case .noResults: noResultsText
            default: listRowItems
            }
        }
        .listStyle(.plain)
    }
    
    // MARK: - listRowItems
    @ViewBuilder
    private var listRowItems: some View {
        var arrayByAlphabet: [(String.Element?, Array<PhoneNumberModel>.SubSequence)] {
            switch state {
            case .defaultArray:
                countryCodePhoneNumbersArray.chunked(on: \.name.first)
            case .filteredArray:
                filteredCountryCodePhoneNumbersArray.chunked(on: \.name.first)
            default: []
            }
        }
        
        List {
            ForEach(arrayByAlphabet, id: \.0) { char, phoneNumbersArray in
                Section(char?.description ?? "") {
                    ForEach(phoneNumbersArray) { item in
                        HStack {
                            Text("\(item.flag) \(item.name) (\(item.dialCode))")
                            Spacer()
                            Image(systemName: "checkmark")
                                .opacity(selectedCountryCode?.name == item.name ? 1 : 0)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(colorScheme == .dark
                                    ? Color(uiColor: .systemGray6)
                                    : .white
                        )
                        .onTapGesture { onListRowTap(item: item) }
                    }
                }
            }
        }
    }
    
    // MARK: - noResultsText
    private var noResultsText: some View {
        CustomContentNotAvailableView(title: "No Results")
            .frame(maxHeight: .infinity)
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - filterResults
    private func filterResults(text: String) {
        if text == "" {
            filteredCountryCodePhoneNumbersArray = []
            state = .defaultArray
        } else {
            let tempFilteredArray: [PhoneNumberModel] = countryCodePhoneNumbersArray
                .filter({
                    $0.name.uppercased().contains(text.uppercased())
                    || $0.dialCode.contains(text)
                    || $0.countryCode.contains(text.uppercased())
                })
            
            withAnimation { filteredCountryCodePhoneNumbersArray = tempFilteredArray }
            state = tempFilteredArray.isEmpty ? .noResults : .filteredArray
        }
    }
    
    // MARK: - onListRowTap
    private func onListRowTap(item: PhoneNumberModel) {
        selectedCountryCode = item
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { isPresented = false }
    }
}
