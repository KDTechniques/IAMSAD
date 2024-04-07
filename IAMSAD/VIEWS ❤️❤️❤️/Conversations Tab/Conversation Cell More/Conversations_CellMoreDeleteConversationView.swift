//
//  Conversations_CellMoreDeleteConversationView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-07.
//

import SwiftUI

struct Conversations_CellMoreDeleteConversationView: View {
    // MARK: - PROPERTIES
    let name: String
    
    // MARK: - INITIALIZER
    init(name: String) {
        self.name = name
    }
    
    // MARK: - BODY
    var body: some View {
        CustomActionSheetView {
            CustomActionSheetHeadlineView(text: "Delete chat with \(name)?")
            
            CustomActionSheetButtonsView {[
                .init(text: "Delete Chat", systemImageName: "trash", role: .destructive) { }
            ]}
        } dismissAction: { ConversationsVM.shared.dismissAction }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_CellMoreDeleteConversationView") {
    Conversations_CellMoreDeleteConversationView(name: "Kasun Desitha")
}
