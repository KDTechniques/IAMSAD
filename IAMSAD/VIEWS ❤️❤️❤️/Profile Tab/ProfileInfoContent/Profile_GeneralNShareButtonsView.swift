//
//  Profile_GeneralNShareButtonsView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI

struct Profile_GeneralNShareButtonsView: View {
    // MARK: - PROPERTIES
    let buttonType: Profile_GeneralButtonTypes
    let isScrolling: Bool
    
    // MARK: - INITIALIZER
    init(buttonType: Profile_GeneralButtonTypes, isScrolling: Bool) {
        self.buttonType = buttonType
        self.isScrolling = isScrolling
    }
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 15) {
            Text(buttonType.rawValue.capitalized)
                .font(.footnote.weight(.semibold))
                .foregroundStyle(Color.primary)
                .frame(width: 130, height: 32)
                .background(.clear)
                .clipShape(.rect(cornerRadius: 9))
                .background(
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(Color(uiColor: .systemGray4), lineWidth: 1)
                )
                .generalTapRegistration(isScrolling: isScrolling)
            
            Circle()
                .stroke(Color(uiColor: .systemGray4), lineWidth: 1)
                .frame(width: 32, height: 32)
                .overlay {
                    Image(.share)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .padding(10)
                }
                .tint(.primary)
                .shareTapRegistration(isScrolling: isScrolling)
        }
    }
}

// MARK: - PREVIEWS
#Preview("Profile_GeneralNShareButtonsView") {
    Profile_GeneralNShareButtonsView(buttonType: .pending, isScrolling: false)
        .previewViewModifier
}

// MARK: - EXTENSIONS
@MainActor
fileprivate extension View {
    // MARK: - generalTapRegistration
    func generalTapRegistration(isScrolling: Bool) -> some View {
        return Group {
            if isScrolling {
                self
            } else {
                self
                    .registerProfileTapEvent(event: Profile_TapEventTypes.general) {
                        // follow/unfollow/edit profile action goes here...
                        print("general - follow/unfollow/edit profile action got triggered...")
                    }
            }
        }
    }
    
    // MARK: - shareTapRegistration
    func shareTapRegistration(isScrolling: Bool) -> some View {
        return Group {
            if isScrolling {
                self
            } else {
                self
                    .registerProfileTapEvent(event: Profile_TapEventTypes.share) {
                        // share action goes here...
                        print("share action got triggered...")
                    }
            }
        }
    }
}
