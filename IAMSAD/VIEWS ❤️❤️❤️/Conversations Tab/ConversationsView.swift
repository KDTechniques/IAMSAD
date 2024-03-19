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

fileprivate struct SampleModel: Identifiable, Hashable {
    let id: String = UUID().uuidString
    let number: Int
}

struct ConversationsView: View {
    // MARK: - PROPERTIES
    let url: URL? = .init(string: "https://picsum.photos/id/\(Int.random(in: 1...500))/300")
    @State private var array: [SampleModel] = []
    @State var searchText: String = ""
    @State var showUnread: Bool = false
    @State private var selection = Set<SampleModel>()
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            List(selection: $selection) {
                ForEach(array, id: \.self) { index in
                    Conversations_ListItemView(
                        accountType: .anonymous,
                        avatar: Avatar.shared.publicAvatarsArray[index.number],
                        imageURL: nil,
                        name: "Deepashika Sajeewanie",
                        badgeType: .blue,
                        time: "Friday",
                        text: "Don't you worry okay, i will help you go through this. Leave a message if you need me anytime. I'll get back to you as soon as i can.",
                        conversationType: .conversationOnPost(isOnMyPost: Bool.random())
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
                }
                .listRowBackground(Color.clear)
                .listSectionSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Conversations")
            .toolbar(.hidden, for: .bottomBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button("Delete") { }
                }
            }
        }
        .searchable(text: $searchText)
        .onAppear {
            var tempArray: [SampleModel] = []
            for index in 0...200 {
                tempArray.append(.init(number: index))
            }
            array = tempArray
        }
    }
}

// MARK: - PREVIEWS
#Preview("ConversationsView") {
    ConversationsView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.tabBarNSystemBackground)
        .previewViewModifier
}
