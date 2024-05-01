//
//  IAMSADApp.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-08.
//

import SwiftUI
import SwiftUIIntrospect

@main
struct IAMSADApp: App {
    
    let avatar: Avatar = .shared
    @StateObject private var avatarSheetVM: AvatarSheetVM = .shared
    @StateObject private var profileVM: ProfileVM = .shared
    @StateObject private var conversationsVM: ConversationsVM = .shared
    
    init() {
        
    }
    
    let texts: [String] = [
        "Test of a hyperlink www.google.co.uk within a text message",
        "www.google.co.uk hyperlink at the start of a text message",
        "Test of hyperlink at the end of a text message www.google.co.uk",
        "www.google.co.uk",
        "This is 1 hyperlink www.google.co.uk.  This is a 2nd hyperlink www.apple.com",
        "This is 1 hyperlink www.google.co.uk.  This is a 2nd hyperlink www.apple.com.  This is text after it.",
        "This is 1 hyperlink www.google.co.uk.  This is a 2nd hyperlink www.apple.com.  This is a 3rd hyperlink www.microsoft.com.  This is text after it.",
        "This is a test of another type of url which will get processed google.co.uk",
        "Pure text with no hyperlink",
        "Emoji test 🙂"
    ]
    
    var body: some Scene {
        WindowGroup {
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(texts, id: \.self) { text in
                        Conversations_MessageBubbleView(
                            direction: .random(),
                            showPointer: true) {
                                Conversations_TextBasedPrimaryBubbleView(
                                    isEdited: .random(),
                                    text: text,
                                    timestamp: "12:12 PM",
                                    status: .seen,
                                    shouldAnimate: false,
                                    height: screenWidth,
                                    withSecondaryContent: false
                                )
                            }
                    }
                }
            }
            .dynamicTypeSize(...DynamicTypeSize.xLarge)
            .environmentObject(avatar)
            .environmentObject(avatarSheetVM)
            .environmentObject(profileVM)
            .environmentObject(conversationsVM)
        }
    }
}
