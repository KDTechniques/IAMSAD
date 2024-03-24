//
//  CustomActionSheetButtonsView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-21.
//

import SwiftUI

struct CustomActionSheetButtonsView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    let buttonsArray: [SheetButtonListModel]
    
    // MARK: - INITIALIZER
    init(_ buttonsArray: () -> [SheetButtonListModel]) {
        self.buttonsArray = buttonsArray()
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 0) {
            ForEach(buttonsArray) { button in
                Button(role: button.role) {
                    button.action()
                } label: {
                    HStack {
                        Text(button.text)
                        Spacer()
                        Image(systemName: button.systemImageName)
                            .font(.title2)
                    }
                    .foregroundStyle(button.role == .destructive ? .red : .primary)
                    .padding()
                }
                .sheetListButtonStyleViewModifier
                .overlay(alignment: .bottom) {
                    if button.id != buttonsArray.last?.id {
                        Divider().padding(.leading)
                    }
                }
            }
        }
        .clipShape(.rect(cornerRadius: 10))
    }
}

// MARK: - PREVIEWS
#Preview("CustomActionSheetButtonsView") {
    let buttonsArray: [SheetButtonListModel] = [
        .init(
            text: "Mute",
            systemImageName: "bell.slash") {
                print("Mute action is working...")
            },
        .init(
            text: "Delete",
            systemImageName: "trash",
            role: .destructive) {
                print("Delete action is working...")
            },
    ]
    
    return CustomActionSheetButtonsView { buttonsArray }.padding(.horizontal)
}

struct SheetButtonListModel: Identifiable {
    // MARK: - PROPERTIES
    let id: String = UUID().uuidString
    let text: String
    let systemImageName: String
    let role:  ButtonRole?
    let action: () -> Void
    
    // MARK: - INITIALIZER
    init(
        text: String,
        systemImageName: String,
        role: ButtonRole? = nil,
        _ action: @escaping () -> Void
    ) {
        self.text = text
        self.systemImageName = systemImageName
        self.role = role
        self.action = action
    }
}
