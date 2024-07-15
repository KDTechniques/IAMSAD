//
//  CustomCountryCodeSearchViewModel.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-14.
//

import SwiftUI
import Combine
import Algorithms

@Observable final class CustomCountryCodeSearchViewModel {
    // MARK: - PROPERTIES
    enum CountryCodeSearchStateTypes { case defaultArray, filteredArray, noResults }
    var cancellables = Set<AnyCancellable>()
    
    var searchText: String = "" { didSet { searchText$ = searchText } }
    @ObservationIgnored
    @Published var searchText$: String = ""
    
    var filteredCountryCodePhoneNumbersArray: [PhoneNumberModel] = []
    var state: CountryCodeSearchStateTypes = .defaultArray
    let countryCodePhoneNumbersArray: [PhoneNumberModel] = PhoneNumberModel
        .getCountryPhoneNumbersArray()?
        .sorted(by: { $0.name < $1.name }) ?? []
    
    private var defaultArray: [(String.Element?, Array<PhoneNumberModel>.SubSequence)] {
        countryCodePhoneNumbersArray.chunked(on: \.name.first)
    }
    
    var arrayByAlphabet: [(String.Element?, Array<PhoneNumberModel>.SubSequence)] {
        switch state {
        case .defaultArray:
            defaultArray
        case .filteredArray:
            filteredCountryCodePhoneNumbersArray.chunked(on: \.name.first)
        default: []
        }
    }
    
    // MARK: - INITIALIZER
    public init() {
        searchTextSubscriber()
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - searchTextSubscriber
    private func searchTextSubscriber() {
        $searchText$
            .removeDuplicates() // Prevent infinite loop
            .sink { [weak self] text in
                guard let self = self else { return }
                searchText = text
                filterResults(text: text)
            }
            .store (in: &cancellables)
    }
    
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
}
