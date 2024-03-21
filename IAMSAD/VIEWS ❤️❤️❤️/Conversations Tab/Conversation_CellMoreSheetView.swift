//
//  Conversation_CellMoreSheetView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-21.
//

import SwiftUI
import SDWebImageSwiftUI

struct Conversation_CellMoreSheetView: View {
    // MARK: - PROPERTIES
    let imageURL: URL? = .init(string: "https://picsum.photos/id/\(Int.random(in: 100...300))/100")
    let accountType:  AccountTypes = .personal
    let avatar: AvatarModel? = Avatar.shared.publicAvatarsArray.first
    let imageSize: CGFloat = 40
    let name: String = "Deepashika Sajeewanie ❤️😘"
    
    let buttonsArray: [SheetButtonListModel] = [
        .init(text: "Send a gift", systemImageName: "gift") { },
        .init(text: "Contact Info", systemImageName: "info.circle") { },
        .init(text: "Add to trusted people", systemImageName: "person.badge.shield.checkmark") { },
        .init(text: "Recommend to a friend", systemImageName: "person.line.dotted.person") { },
        .init(text: "Lock conversation", systemImageName: "lock") { },
        .init(text: "Clear conversation", systemImageName: "xmark.circle") { }
    ]
    
    var destructiveButtonsArray: [SheetButtonListModel] { [
        .init(text: "Block \(name)", systemImageName: "hand.raised", role: .destructive) { },
        .init(text: "Delete Conversation", systemImageName: "trash", role: .destructive) { }
    ]}
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                // profile image
                Group {
                    switch accountType {
                    case .personal:
                        if let imageURL {
                            WebImage(
                                url: imageURL,
                                options: [.scaleDownLargeImages, .retryFailed]
                            )
                            .resizable()
                            .defaultBColorPlaceholder(Color(uiColor: .systemGray5))
                            .scaledToFill()
                            .clipShape(Circle())
                        } else {
                            CustomNoProfileImageView()
                        }
                        
                    case .anonymous:
                        if let avatar {
                            AvatarImageView(avatar: avatar, borderSize: 1.5)
                        } else {
                            CustomNoProfileImageView()
                        }
                    }
                }
                .frame(width: imageSize, height: imageSize)
                
                // name
                Text(name)
                    .font(.headline)
                    .lineLimit(1)
                    .padding(.trailing, 50)
                
                Spacer()
            }
            
            CustomSheetButtonsListView { buttonsArray }
                .padding(.top, 2)
            
            CustomSheetButtonsListView { destructiveButtonsArray }
        }
        .padding()
        .sheetTopTrailingCloseButtonViewModifier(size: 30) {
            // action goes here...
            print("Sheet close action is working...")
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversation_CellMoreSheetView") {
    Conversation_CellMoreSheetView_Preview().previewViewModifier
}

struct Conversation_CellMoreSheetView_Preview: View {
    @State private var height: CGFloat = 0
    var body: some View {
        Color.clear
            .sheet(isPresented: .constant(true)) {
                Conversation_CellMoreSheetView()
                    .presentationDetents([.height(height)])
                    .presentationCornerRadius(20)
                    .presentationBackground(Color(uiColor: .systemGray6))
                    .geometryReaderDimensionViewModifier($height, dimension: .height)
            }
    }
}

#Preview("ConversationsView") {
    ConversationsView()
        .previewViewModifier
}
