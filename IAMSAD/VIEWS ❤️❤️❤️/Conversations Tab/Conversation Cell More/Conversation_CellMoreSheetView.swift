//
//  Conversation_CellMoreSheetView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-21.
//

import SwiftUI
import SDWebImageSwiftUI

struct Conversation_CellMoreSheetView: View {
    // MARK: - PROPERTIES
    let imageURL: URL? = .init(string: "https://picsum.photos/id/\(Int.random(in: 100...300))/100")
    let accountType:  AccountTypes = .personal
    let avatar: AvatarModel? = Avatar.shared.publicAvatarsArray.first
    let name: String
    var dismissAction: () {
        DispatchQueue.main.async {
            ConversationsVM.shared.dismissAction
        }
    }
    
    var buttonsArray: [SheetButtonListModel] {[
        .init(text: "Send a gift", systemImageName: "gift") { },
        .init(text: "Contact Info", systemImageName: "info.circle") { },
        .init(text: "Add to trusted people", systemImageName: "person.badge.plus") { },
        .init(text: "Recommend to a friend", systemImageName: "person.line.dotted.person") { },
        .init(text: "Lock conversation", systemImageName: "lock") { },
        .init(text: "Clear conversation", systemImageName: "xmark.circle") {
            DispatchQueue.main.async {
                ConversationsVM.shared.clearConversation(name: name)
            }
        }
    ]}
    
    var destructiveButtonsArray: [SheetButtonListModel] {[
        .init(text: "Block \(name)", systemImageName: "hand.raised", role: .destructive) {
            DispatchQueue.main.async {
                ConversationsVM.shared.blockConversation(name: name)
            }
        },
        .init(text: "Delete Conversation", systemImageName: "trash", role: .destructive) {
            DispatchQueue.main.async {
                ConversationsVM.shared.deleteConversation(name: name)
            }
        }
    ]}
    
    // MARK: - INITIALIZER
    init(name: String) {
        self.name = name
    }
    
    // MARK: - BODY
    var body: some View {
        CustomActionSheetView {
            CustomActionSheetHeadlineView(
                text: name,
                accountType: accountType,
                imageURL: imageURL,
                avatar: avatar
            )
            
            CustomActionSheetButtonsView { buttonsArray }
            
            CustomActionSheetButtonsView { destructiveButtonsArray }
        } dismissAction: { dismissAction }
    }
}

// MARK: - PREVIEWS
#Preview("Conversation_CellMoreSheetView") {
    Conversation_CellMoreSheetView_Preview().previewViewModifier
}

struct Conversation_CellMoreSheetView_Preview: View {
    @EnvironmentObject private var conversationsVM: ConversationsVM
    @State private var height: CGFloat = 0
    var body: some View {
        Color.clear
            .sheet(item: $conversationsVM.sheetItem) { $0.content }
            .onAppear {
                conversationsVM.sheetItem = .init(AnyView(
                    Conversation_CellMoreSheetView(name: "Wifey ❤️😘")
                ))
            }
    }
}

#Preview("ConversationsView") {
    ConversationsView().previewViewModifier
}

#Preview("ContentView") {
    ContentView().previewViewModifier
}
