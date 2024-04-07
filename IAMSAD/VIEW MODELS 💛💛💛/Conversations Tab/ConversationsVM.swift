//
//  ConversationsVM.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-07.
//

import SwiftUI

@MainActor
final class ConversationsVM: ObservableObject {
    // MARK: - PROPERTIES
    @Published var sheetItem: ActionSheetModel<AnyView>? = nil
    var dismissAction: () { sheetItem = nil }
    
    // MARK: Singleton
    static let shared: ConversationsVM = .init()
    
    // MARK: - INITITLIZER
    private init() { }
    
    // MARK: - FUNCTIONS
    
    // MARK: - blockConversation
    func blockConversation(name: String) {
        sheetItem = .init(AnyView(
            Conversations_CellMoreBlockConversationView(name: name)
        ))
    }
    
    // MARK: - deleteConversation
    func deleteConversation(name: String) {
        sheetItem = .init(AnyView(
            Conversations_CellMoreDeleteConversationView(name: name)
        ))
    }
    
    // MARK: - clearConversation
    func clearConversation(name: String) {
        sheetItem = .init(AnyView(
            Conversations_CellMoreClearConversationView(name: name)
        ))
    }
    
    
}
