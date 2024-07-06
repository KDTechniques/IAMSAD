//
//  ConversationsView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-18.
//

import SwiftUI
import SDWebImageSwiftUI

enum ConversationTypes: Equatable {
    case conversationOnPost(isOnMyPost: Bool)
    case conversationOverDirectMessage
}

struct ConversationsView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var conversationsVM: ConversationsVM
    
    @State var searchText: String = ""
    @State var showUnread: Bool = false
    @State private var selection = Set<Int>()
    @State var editMode: EditMode = .inactive
    @State private var showTabBar: Bool = true
    @State private var showBottomBar: Bool = false
    let avatar: Avatar = .shared
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            List(0...50, id: \.self, selection: $selection) { index in
                if let avatarsArray: [AvatarModel] = avatar.publicAvatarsDictionary[.random()] {
                    Conversations_ListItemView(
                        accountType: .anonymous,
                        avatar: avatarsArray[index],
                        imageURL: .init(string: "https://picsum.photos/id/\(Int.random(in: 100...300))/150"),
                        name: "Deepashika Sajeewanie",
                        badgeType: .blue,
                        time: "Friday",
                        text: "Don't you worry okay, i will help you go through this. Leave a message if you need me anytime. I'll get back to you as soon as i can.",
                        conversationType: .conversationOnPost(isOnMyPost: false)
                    )
                    .leadingSwipeGestures
                    .trailingSwipeGestures(name: "Deepashika Sajeewanie")
                    .listRowBackground(Color.clear)
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Conversations")
            .toolbar(showTabBar ? .visible : .hidden, for: .tabBar)
            .toolbar(showBottomBar ? .visible : .hidden, for: .bottomBar)
            .environment(\.editMode, $editMode)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { topBarLeadingToolbarContent }
                
                ToolbarItem(placement: .topBarTrailing) { topBarTrailingToolbarContent }
                
                ToolbarItem(placement: .bottomBar) { bottomToolbarContent }
            }
            .sheet(item: $conversationsVM.sheetItem) { $0.content }
        }
        .searchable(text: $searchText)
    }
}

// MARK: - PREVIEWS
#Preview("ConversationsView") {
    ConversationsView()
        .previewViewModifier
}

#Preview("ContentView") {
    ContentView()
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension ConversationsView {
    // MARK: - topBarLeadingToolbarContent
    @ViewBuilder
    private var topBarLeadingToolbarContent: some View {
        if editMode == .active {
            Button("Done") {
                withAnimation {
                    editMode = .inactive
                    showBottomBar = false
                    showTabBar = true
                }
            }
        } else {
            Menu {
                Button {
                    withAnimation {
                        editMode = .active
                        showTabBar = false
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.55) {
                        withAnimation {
                            showBottomBar = true
                        }
                    }
                } label: {
                    Label("Select Conversations", systemImage: "checkmark.circle")
                }
            } label: {
                Image(systemName: "ellipsis.circle")
            }
        }
    }
    
    // MARK: - topBarTrailingToolbarContent
    private var topBarTrailingToolbarContent: some View {
        Menu {
            Button {
                // action goes here...
            } label: {
                Label("Show Unread", systemImage: "envelope")
            }
            
            Button {
                // action goes here...
            } label: {
                Label("Show trusted people", systemImage: "person.badge.shield.checkmark")
            }
            
        } label: {
            Image(systemName: "line.3.horizontal.decrease.circle")
        }
    }
    
    // MARK: - bottomToolbarContent
    private var bottomToolbarContent: some View {
        HStack {
            Button("Mute") { conversationsVM.mute() }
            Spacer()
            Button("Read All") { conversationsVM.readAll() }
            Spacer()
            Button("Delete") { conversationsVM.delete() }
        }
        .disabled(selection.count == 0)
    }
}

@MainActor
extension View {
    // MARK: - leadingSwipeGestures
    fileprivate var leadingSwipeGestures: some View {
        self
            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                Button {
                    // action goes here...
                } label: {
                    Label("Unread", systemImage: "message.badge.fill")
                }
                .tint(.unreadSwipeAction)
                
                Button {
                    // action goes here...
                } label: {
                    Label("Pin", systemImage: "pin.fill")
                }
                .tint(.secondarySwipeAction)
            }
    }
    
    // MARK: - trailingSwipeGestures
    fileprivate func trailingSwipeGestures(name: String) -> some View {
        self
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button {
                    // action goes here...
                } label: {
                    Label("Mute", systemImage: "bell.slash.fill")
                }
                .tint(.muteSwipeAction)
                
                Button {
                    ConversationsVM.shared.moreActionSheet(name: name)
                } label: {
                    Label("More", systemImage: "ellipsis.circle.fill")
                        .fontWeight(.heavy)
                }
                .tint(.secondarySwipeAction)
            }
    }
}
