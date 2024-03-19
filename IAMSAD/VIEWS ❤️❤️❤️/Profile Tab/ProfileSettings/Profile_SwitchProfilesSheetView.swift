//
//  Profile_SwitchProfilesSheetView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-16.
//

import SwiftUI
import SDWebImageSwiftUI

struct Profile_SwitchProfilesSheetView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var profileVM: ProfileVM
    @EnvironmentObject private var avatarSheetVM: AvatarSheetVM
    
    @Binding var isPresented: Bool
    
    @State var contentHeight: CGFloat = 0
    
    // MARK: - INITIALIZER
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 20) {
            CardView(
                isPresented: $isPresented,
                selectedAccountType: $profileVM.selectedAccount,
                accountType: .personal,
                name: profileVM.personalName,
                imageURL: profileVM.profilePhotoURL
            )
            
            CardView(
                isPresented: $isPresented,
                selectedAccountType: $profileVM.selectedAccount,
                accountType: .anonymous,
                name: profileVM.anonymousName,
                avatar: avatarSheetVM.selectedAvatar,
                backgroundColor: avatarSheetVM.selectedBackgroundColor.toColor()
            )
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 40)
        .geometryReaderDimensionViewModifier($contentHeight, dimension: .height)
        .presentationDragIndicator(.visible)
        .presentationDetents([.height(contentHeight)])
        .presentationCornerRadius(30)
        .onAppear {
            avatarSheetVM.selectedAvatar = Avatar.shared.publicAvatarsArray[78]
        }
    }
}

// MARK: - PREVIEWS
#Preview("Profile_SwitchProfilesSheetView") {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            Profile_SwitchProfilesSheetView(isPresented: .constant(true))
        }
        .previewViewModifier
}

// MARK: - SUBVIEWS

// MARK: - CardView
fileprivate struct CardView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var isPresented: Bool
    @Binding var selectedAccountType: AccountTypes
    let accountType: AccountTypes
    let name: String
    let imageURL: URL?
    let avatar: AvatarModel?
    let backgroundColor: Color?
    
    let imageSize: CGFloat = 50
    
    // MARK: - INITIALIZER
    init(
        isPresented: Binding<Bool>,
        selectedAccountType: Binding<AccountTypes>,
        accountType: AccountTypes,
        name: String,
        imageURL: URL? = nil,
        avatar: AvatarModel? = nil,
        backgroundColor: Color? = nil
    ) {
        self._isPresented = isPresented
        self._selectedAccountType = selectedAccountType
        self.accountType = accountType
        self.name = name
        self.imageURL = imageURL
        self.avatar = avatar
        self.backgroundColor = backgroundColor
    }
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 16) {
            image
            texts
            Spacer()
            checkmark
        }
        .padding()
        .padding(.vertical, 2)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(uiColor: .systemGray5), lineWidth: 1)
        )
        .background(Color(uiColor: colorScheme == .dark ? .systemGray6 : .white))
        .onTapGesture { handleTap() }
    }
}

// MARK: - EXTENSIONS
extension CardView {
    // MARK: - image
    private var image: some View {
        Group {
            switch accountType {
            case .personal:
                if let imageURL {
                    WebImage(url: imageURL, options: [.scaleDownLargeImages])
                        .resizable()
                        .scaledToFill()
                } else {
                    CustomNoProfileImageView()
                }
                
            case .anonymous:
                if let avatar {
                    AvatarImageView(
                        color: backgroundColor ?? .white,
                        avatar: avatar
                    )
                } else {
                    CustomNoProfileImageView()
                }
            }
        }
        .clipShape(Circle())
        .frame(width: imageSize, height: imageSize)
        .overlay(
            Circle()
                .stroke(.separator, lineWidth: 0.7)
        )
    }
    
    // MARK: - texts
    private var texts: some View {
        VStack(alignment: .leading) {
            Text(name)
                .fontWeight(.semibold)
            
            Text("\(accountType.rawValue.capitalized) Profile")
                .foregroundStyle(.secondary)
        }
        .font(.footnote)
    }
    
    // MARK: - checkmark
    private var checkmark: some View {
        Image(systemName: "checkmark")
            .opacity(selectedAccountType == accountType ? 1 : 0)
    }
    
    // MARK: - FUNCTIONS
    
    // MARK: - handleTap
    private func handleTap() {
        selectedAccountType = accountType
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            isPresented = false
        }
    }
}
