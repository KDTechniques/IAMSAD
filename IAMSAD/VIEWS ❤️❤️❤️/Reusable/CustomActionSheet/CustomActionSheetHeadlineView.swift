//
//  CustomActionSheetHeadlineView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-22.
//

import SwiftUI

struct CustomActionSheetHeadlineView: View {
    // MARK: - PROPERTIES
    let text: String
    let accountType: AccountTypes?
    let imageURL: URL?
    let avatar: AvatarModel?
    
    let imageSize: CGFloat = 40
    var frameHeight: CGFloat { imageSize + 2 }
    
    // MARK: - INITIALIZER
    init(
        text: String,
        accountType: AccountTypes? = nil,
        imageURL: URL? = nil,
        avatar: AvatarModel? = nil
    ) {
        self.text = text
        self.accountType = accountType
        self.imageURL = imageURL
        self.avatar = avatar
    }
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 12) {
            if let accountType {
                CustomProfileImageView(
                    accountType: accountType,
                    imageURL: imageURL,
                    avatar: avatar,
                    imageSize: imageSize,
                    borderSize: 1.5
                )
            }
            
            Text(text)
                .font(.headline)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(accountType == nil ? .center : .leading)
        }
        .frame(height: frameHeight)
        .frame(maxWidth: .infinity, alignment: accountType == nil ? .center : .leading)
        .setPadding(accountType == nil)
    }
}

// MARK: - PREVIEWS
#Preview("CustomActionSheetHeadlineView - text only") {
    CustomActionSheetHeadlineView(text: "Clear all messages from \"Kasun Desitha\"")
}

#Preview("CustomActionSheetHeadlineView - personal") {
    CustomActionSheetHeadlineView(
        text: "Clear all messages from \"Kasun Desitha\"",
        accountType: .personal,
        imageURL: .init(string: "https://picsum.photos/100")
    )
}

#Preview("CustomActionSheetHeadlineView - anonymous") {
    if let avatar: AvatarModel = Avatar.shared.publicAvatarsDictionary[.random()]?.first {
        CustomActionSheetHeadlineView(
            text: "Clear all messages from \"Kasun Desitha\"",
            accountType: .anonymous,
            avatar: avatar
        )
    }
}

// MARK: - EXTENSIONS
extension View {
    // MARK: - setPadding
    fileprivate func setPadding(_ textOnly: Bool) -> some View {
        let padding: CGFloat = 50
        return textOnly
        ? self.padding(.horizontal, padding)
        : self.padding(.trailing, padding)
    }
}
