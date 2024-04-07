//
//  Conversations_CellMoreClearConversationView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-07.
//

import SwiftUI

struct Conversations_CellMoreClearConversationView: View {
    // MARK: - PROPERTIES
    let name: String
    
    // MARK: - INITIALIZER
    init(name: String) {
        self.name = name
    }
    
    // MARK: - BODY
    var body: some View {
        CustomActionSheetView {
            CustomActionSheetHeadlineView(text: "Clear all messages from \"\(name)\"?")
            
            CustomActionSheetSubHeadlineView("This chat will be empty but will remain in your chat list. 123456789")
            
            CustomActionSheetButtonsView {[
                .init(text: "Clear All Messages", systemImageName: "xmark.circle", role: .destructive) { }
            ]}
        } dismissAction: { ConversationsVM.shared.dismissAction }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_CellMoreClearConversationView") {
    Conversations_CellMoreClearConversationView(name: "Kasun Desitha")
}
