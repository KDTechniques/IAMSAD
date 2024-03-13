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
                    horizontalTabHeight: profileVM.horizontalTabHeight
                )
                
                ForEach(profileVM.array) { item in
                    MockText(item: item)
                        .padding(.bottom, 100)
                }
                .padding(.top)
            }
        }
        .profile_introspectViewModifier(for: .posts)
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
            
//            CustomLikeHeartAnimationView(like: like, size: 60)
//                .onTapGesture {
//                    like.toggle()
//                }
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


extension View {
    @MainActor @ViewBuilder
    func profile_introspectViewModifier(for type: Profile_TabLabelTypes) -> some View {
        let profileVM: ProfileViewModel = .shared
        self
            .introspect(.scrollView, on: .iOS(.v17)) { scrollView in
                
                
                
                
//                guard let index: Int = profileVM.contentOffsetYArray.firstIndex(where: { $0.tab == type }),
//                      let offsetY: CGFloat = profileVM.contentOffsetYArray[index].offsetY
//                      /*profileVM.selectedTabType == type*/ else { return }
//                
//                
//                scrollView.contentOffset.y = offsetY
////                profileVM.contentOffsetYArray[index].setToNil()
//                
//                print("hello")
            }
    }
}
