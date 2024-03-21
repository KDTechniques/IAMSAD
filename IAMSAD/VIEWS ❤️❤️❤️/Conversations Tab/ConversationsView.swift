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
    @State private var array: [Int] = Array(0...50)
    @State var searchText: String = ""
    @State var showUnread: Bool = false
    @State private var selection = Set<Int>()
    @State var editMode: EditMode = .inactive
    @State private var showTabBar: Bool = true
    @State private var showBottomBar: Bool = false
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            List(array, id: \.self, selection: $selection) { index in
                Conversations_ListItemView(
                    accountType: .personal,
//                    avatar: Avatar.shared.publicAvatarsArray[index],
                    imageURL: .init(string: "https://picsum.photos/id/\(Int.random(in: 1...500))/150"),
                    name: "Deepashika Sajeewanie",
                    badgeType: .blue,
                    time: "Friday",
                    text: "Don't you worry okay, i will help you go through this. Leave a message if you need me anytime. I'll get back to you as soon as i can.",
                    conversationType: .conversationOnPost(isOnMyPost: false)
                )
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
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button {
                        // action goes here...
                    } label: {
                        Label("Mute", systemImage: "bell.slash.fill")
                    }
                    .tint(.muteSwipeAction)
                    
                    Button {
                        // action goes here...
                    } label: {
                        Label("More", systemImage: "ellipsis.circle.fill")
                            .fontWeight(.heavy)
                    }
                    .tint(.secondarySwipeAction)
                }
                .listRowBackground(Color.clear)
                .listSectionSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Conversations")
            .toolbar(showTabBar ? .visible : .hidden, for: .tabBar)
            .toolbar(showBottomBar ? .visible : .hidden, for: .bottomBar)
            .environment(\.editMode, $editMode)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
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
                                
                                DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
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
                
                ToolbarItem(placement: .topBarTrailing) {
                    
                }
                
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button("Mute") { }
                        Spacer()
                        Button("Read All") { }
                        Spacer()
                        Button("Delete") { }
                    }
                    .disabled(selection.count == 0)
                }
            }
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
