//
//  Profile_PostsTabView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-12.
//

import SwiftUI
import SwiftUIIntrospect

struct Profile_PostsTabView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var profileVM: ProfileViewModel
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                Profile_TabContentTopClearView(
                    topContentHeight: profileVM.profileContentHeight,
                    horizontalTabHeight: profileVM.horizontalTabHeight,
                    tab: .posts,
                    selectedTab: profileVM.selectedTabType
                )
                
                ForEach(profileVM.array) { item in
                    MockText(item: item)
                        .padding(.bottom, 100)
                }
                .padding(.top)
            }
        }
        .introspect(.scrollView, on: .iOS(.v17)) { scrollView in
            let condition: Bool = profileVM.contentOffset.y <= profileVM.contentOffsetMaxY
            
            if profileVM.currentGestureType == .drag {
                if profileVM.selectedTabType != .posts, condition {
                    scrollView.contentOffset.y = profileVM.contentOffset.y
                }
            } else if condition {
                scrollView.contentOffset.y = profileVM.contentOffset.y
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - PREVIEWS
#Preview("Profile_PostsTabView") {
    Profile_PostsTabView()
        .previewViewModifier
}

struct MockText: View {
    let item: MockModel
    @State var like: Bool = false
    var body: some View {
        HStack {
            MockView(item: item)
            
            CustomLikeHeartAnimationView(like: like, size: 60)
                .onTapGesture {
                    like.toggle()
                }
        }
    }
}

fileprivate struct MockView: View {
    let item: MockModel
    var body: some View {
        Button(item.text) {
            updateItem(item: item)
            ProfileViewModel.shared.array.append(.init(text: UUID().uuidString))
        }
    }
    
    @MainActor
    func updateItem(item: MockModel) {
        let profileVM: ProfileViewModel = ProfileViewModel.shared
        
        if let index: Int = profileVM
            .array.firstIndex(where: { $0.id == item.id }) {
            profileVM.array[index].updateText(UUID().uuidString)
        }
    }
}


struct MockModel: Identifiable {
    let id: String = UUID().uuidString
    var text: String
    
    mutating func updateText(_ text: String) {
        self.text =  text
    }
}
