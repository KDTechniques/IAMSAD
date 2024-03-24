//
//  CustomActionSheetHeadlineView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-22.
//

import SwiftUI
import SDWebImageSwiftUI

struct CustomActionSheetHeadlineView: View {
    // MARK: - PROPERTIES
    let text: String
    let textOnly: Bool
    let accountType: AccountTypes
    let imageURL: URL?
    let avatar: AvatarModel?
    let alignment: HorizontalAlignment
    
    let imageSize: CGFloat = 40
    var frameHeight: CGFloat { imageSize + 2 }
    
    // MARK: - INITIALIZER
    init(
        text: String,
        textOnly: Bool = true,
        accountType: AccountTypes,
        imageURL: URL? = nil,
        avatar: AvatarModel? = nil,
        alignment: HorizontalAlignment = .center
    ) {
        self.text = text
        self.textOnly = textOnly
        self.accountType = accountType
        self.imageURL = imageURL
        self.avatar = avatar
        self.alignment = alignment
    }
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 12) {
            if !textOnly {
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
                .multilineTextAlignment(alignment == .center ? .center : .leading)
        }
        .frame(height: frameHeight)
        .frame(maxWidth: .infinity, alignment: .init(horizontal: alignment, vertical: .center))
        .setPadding(alignment)
    }
}

// MARK: - PREVIEWS
#Preview("CustomActionSheetHeadlineView - text only") {
    CustomActionSheetHeadlineView(
        text: "Clear all messages from \"Kasun Desitha\"",
        accountType: .anonymous // doesn't really matter what the account type is here.
    )
}

#Preview("CustomActionSheetHeadlineView - personal") {
    CustomActionSheetHeadlineView(
        text: "Clear all messages from \"Kasun Desitha\"",
        textOnly: false,
        accountType: .personal,
        imageURL: .init(string: "https://picsum.photos/100"),
        alignment: .leading
    )
}

#Preview("CustomActionSheetHeadlineView - personal - no image") {
    CustomActionSheetHeadlineView(
        text: "Clear all messages from \"Kasun Desitha\"",
        textOnly: false,
        accountType: .personal,
        alignment: .leading
    )
}

#Preview("CustomActionSheetHeadlineView - anonymous") {
    CustomActionSheetHeadlineView(
        text: "Clear all messages from \"Kasun Desitha\"",
        textOnly: false,
        accountType: .anonymous,
        avatar: Avatar.shared.publicAvatarsArray.first!,
        alignment: .leading
    )
}

#Preview("CustomActionSheetHeadlineView - anonymous - no image") {
    CustomActionSheetHeadlineView(
        text: "Clear all messages from \"Kasun Desitha\"",
        textOnly: false,
        accountType: .anonymous,
        alignment: .leading
    )
}

// MARK: - EXTENSIONS
extension View {
    // MARK: - setPadding
    @ViewBuilder
    fileprivate func setPadding(_ alignment: HorizontalAlignment) -> some View {
        let padding: CGFloat = 50
        
        switch alignment {
        case .leading:
            self.padding(.trailing, padding)
        case .center:
            self.padding(.horizontal, padding)
        default: self
        }
    }
}
