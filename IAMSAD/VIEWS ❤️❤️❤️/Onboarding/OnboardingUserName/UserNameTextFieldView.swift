//
//  UserNameTextFieldView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-09.
//

import SwiftUI

struct UserNameTextFieldView: View {
    // MARK: - PROPERTIES
    @State private var userNameTextFieldText: String = ""
    @State private var userNameStatus: UserNameStatusTypes = .none
    let maxCharactersCount: Int = 20
    
    // MARK: - BODY
    var body: some View {
        VStack {
            TextField(
                "example: kd_techniques 👨🏻‍💻",
                text: $userNameTextFieldText.maxCharacters(20)
            )
            .autocorrectionDisabled()
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .multilineTextAlignment(.center)
            .fontWeight(.semibold)
            .background(textFieldBackground)
            .background(alignment: .topLeading) { characterLimitText }
            .overlay(alignment: .trailing) { userNameStatusIndicator }
            .padding(.vertical)
            
            userNameStatusText
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - PREVIEWS
#Preview("UserNameTextFieldView") {
    UserNameTextFieldView()
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension UserNameTextFieldView {
    // MARK: - textFieldBackground
    private var textFieldBackground: some View {
        RoundedRectangle(cornerRadius: 8)
            .stroke(Color(uiColor: textFieldStrokeColor()), lineWidth: 1.5)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(textFieldBackgroundColor())
            )
    }
    
    // MARK: - characterLimitText
    private var characterLimitText: some View {
        Text("^[\(maxCharactersCount - userNameTextFieldText.count) characters](inflect: true) left")
            .font(.caption.weight(.medium))
            .foregroundColor(.secondary)
            .offset(x: 4, y: -18)
            .onTapGesture {
                // remove this tap gesture later...
                let array = UserNameStatusTypes.allCases
                let randomNumber = Int.random(in: 0..<array.count)
                userNameStatus = array[randomNumber]
            }
    }
    
    // MARK: - userNameStatusIndicator
    private var userNameStatusIndicator: some View {
        Group {
            switch userNameStatus {
            case .verifying:
                ProgressView()
            case .inUse:
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(.red)
            case .approved:
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green)
            case .none:
                EmptyView()
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - userNameStatusText
    private var userNameStatusText: some View {
        Text(userNameStatus.rawValue)
            .font(.subheadline.weight(.semibold))
            .foregroundColor(userNameStatusColor())
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - userNameStatusColor
    private func userNameStatusColor() -> Color {
        switch userNameStatus {
        case .verifying: .secondary
        case .inUse: .red
        case .approved: .green
        case .none: .clear
        }
    }
    
    // MARK: - textFieldStrokeColor
    private func textFieldStrokeColor() -> UIColor {
        switch userNameStatus {
        case .inUse: .red
        default: .systemGray5
        }
    }
    
    // MARK: - textFieldBackgroundColor
    private func textFieldBackgroundColor() -> Color {
        switch userNameStatus {
        case .inUse: .red.opacity(0.2)
        default: Color(uiColor: .systemGray6)
        }
    }
}
