//
//  OnboardingPhoneNumberView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-14.
//

import SwiftUI
import SDWebImageSwiftUI

struct OnboardingPhoneNumberView: View {
    // MARK: - PROPERTIES
    @State private var textFieldText: String = ""
    @State private var selectedCountryCode: PhoneNumberModel? = nil
    @State private var isPresentedCountryCodeSearchSheet: Bool = false
    let currentRegion: String? = NSLocale.current.region?.identifier
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Color(uiColor: .systemBackground)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    titleIcon
                    OnboardingTitleTextView(text: "Create Your Account with Your Phone Number")
                    countryCodeTextField
                    list
                }
                .padding(.vertical, 50)
            }
        }
        .safeAreaInset(edge: .bottom) { agreementText }
        .onAppear { setDefaultRegionCode() }
        .onTapGesture { UIApplication.shared.endEditing(true) }
        .sheet(isPresented: $isPresentedCountryCodeSearchSheet) {
            CustomCountryCodeSearchSheetView(
                isPresented: $isPresentedCountryCodeSearchSheet,
                selectedCountryCode: $selectedCountryCode
            )
            .presentationDragIndicator(.visible)
        }
    }
}

// MARK: - PREVIEWS
#Preview("OnboardingPhoneNumberView") {
    OnboardingPhoneNumberView()
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension OnboardingPhoneNumberView {
    // MARK: - titleIcon
    private var titleIcon: some View {
        AnimatedImage(name: "Telephone")
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
    }
    
    // MARK: - countryCodeSelection
    private var countryCodeSelection: some View {
        Button { isPresentedCountryCodeSearchSheet = true } label: {
            HStack {
                Text(selectedCountryCode?.flag ?? "")
                    .font(.title)
                
                Text(selectedCountryCode?.dialCode ?? "")
                    .kerning(0.5)
            }
        }
    }
    
    // MARK: - textField
    private var textField: some View {
        TextField("Your phone", text: $textFieldText)
            .autocorrectionDisabled()
            .lineLimit(1)
            .kerning(0.5)
            .keyboardType(.numberPad)
    }
    
    // MARK: - countryCodeTextField
    private var countryCodeTextField: some View {
        HStack {
            countryCodeSelection
            textField
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .font(.title2.weight(.medium))
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(uiColor: .systemGray5), lineWidth: 1.5)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(uiColor: .systemGray6))
                )
        )
        .padding(20)
        .onTapGesture { }
    }
    
    // MARK: - list
    private var list: some View {
        OnboardingListView {
            OnboardingListItemView(
                imageName: "ManTechnologist",
                text: "Your phone number is used for account authentication and can be edited later in settings."
            )
            
            OnboardingListItemView(
                imageName: "Email",
                text: "You can add a recovery email address in settings later in case you lose your phone number."
            )
        }
        .padding(.top, 40)
    }
    
    // MARK: - agreementText
    private var agreementText: some View {
        Text("By tapping '**Continue**', you agree to our [Privacy Policy](https://www.example.com) and [Terms of Use](https://www.example.com).")
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.vertical)
            .background(.ultraThinMaterial)
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - setDefaultRegionCode
    private func setDefaultRegionCode() {
        guard let phoneNumbersArray: [PhoneNumberModel] = PhoneNumberModel.getCountryPhoneNumbersArray() else {
            // send analytics here...
            // show an alert apologizing the user...
            return
        }
        
        if let currentRegion: String,
           let item: PhoneNumberModel = phoneNumbersArray.first(where: { $0.countryCode == currentRegion }) {
            selectedCountryCode = item
        } else {
            if let defaultItem: PhoneNumberModel = phoneNumbersArray.first(where: { $0.countryCode == "US" }) {
                selectedCountryCode = defaultItem
            } else {
                selectedCountryCode = phoneNumbersArray.first
            }
        }
    }
}
