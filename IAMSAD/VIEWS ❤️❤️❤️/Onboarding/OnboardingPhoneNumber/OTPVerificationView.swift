//
//  OTPVerificationView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-13.
//

import SwiftUI
import SDWebImageSwiftUI

struct OTPVerificationView: View {
    // MARK: - PROPERTIES
    @State private var textFieldText: String = ""
    @FocusState private var isFocused: Bool
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Color(uiColor: .systemBackground)
            
            VStack {
                Text("Enter the code we sent to\n+94770050165")
                    .multilineTextAlignment(.center)
                    .font(.title3.weight(.semibold))
                
                TextField("######", text: $textFieldText)
                    .focused($isFocused)
                    .autocorrectionDisabled()
                    .lineLimit(1)
                    .kerning(5)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .font(.largeTitle.weight(.semibold))
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(uiColor: .systemGray5), lineWidth: 1.5)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(uiColor: .systemGray6))
                            )
                    )
                    .padding(.horizontal, 50)
                    .padding(.vertical, 20)
                    .onTapGesture { }
                
                Spacer()
                
                Button("Change the phone number") {
                    // switch back to phone number view using an if condition
                }
            }
            .padding(.vertical, 50)
        }
        .onTapGesture { UIApplication.shared.endEditing(true) }
        .onAppear { isFocused = true }
    }
}

// MARK: - PREVIEWS
#Preview("OTPVerificationView") {
    OTPVerificationView()
        .previewViewModifier
}
