//
//  Conversations_CellMoreBlockConversationView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-07.
//

import SwiftUI

struct Conversations_CellMoreBlockConversationView: View {
    // MARK: - PROPERTIES
    let name: String
    
    // MARK: - INITIALIZER
    init(name: String) {
        self.name = name
    }
    
    // MARK: - BODY
    var body: some View {
        CustomActionSheetView {
            CustomActionSheetHeadlineView(text: "Block \"\(name)\"?")
            
            CustomActionSheetSubHeadlineView("Blocked contacts will no longer be able to call you or send you messages.\n\nIf you block and report this contact, the last 5 messages will be forwarded to WhatsApp and your chat with this contact will be deleted from this device only.")
            
            CustomActionSheetButtonsView {[
                .init(text: "Block", systemImageName: "hand.raised", role: .destructive) { },
                .init(text: "Block and Report", systemImageName: "exclamationmark.triangle", role: .destructive) { }
            ]}
        } dismissAction: { ConversationsVM.shared.dismissAction }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_CellMoreBlockConversationView") {
    Conversations_CellMoreBlockConversationView(name: "Kasun Desitha")
}
