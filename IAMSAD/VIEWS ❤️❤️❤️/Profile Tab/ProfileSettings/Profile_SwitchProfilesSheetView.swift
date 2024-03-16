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
    
    @State var isPresented: Bool = !false
    @State var contentHeight: CGFloat = 0
    let imageSize: CGFloat = 50
    
    // MARK: - INITIALIZER
    
    
    // MARK: - BODY
    var body: some View {
        Button("Present") {
            isPresented = true
        }
        .onAppear {
            avatarSheetVM.selectedAvatar = Avatar.shared.publicAvatarsArray[78]
        }
        .sheet(isPresented: $isPresented) {
            VStack(spacing: 20) {
                
                // Personal
                HStack(spacing: 16) {
                    WebImage(url: profileVM.profilePhotoURL, options: [.scaleDownLargeImages])
                        .resizable()
                        .defaultBColorPlaceholder
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: imageSize, height: imageSize)
                    
                    VStack(alignment: .leading) {
                        Text(profileVM.personalName)
                            .font(.footnote.weight(.medium))
                        
                        Text("Personal Account")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "checkmark")
                        .opacity(profileVM.selectedAccount == .personal ? 1 : 0)
                }
                .padding()
                .padding(.vertical, 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(uiColor: .systemGray3), lineWidth: 1)
                )
                
                // Anonymous
                HStack(spacing: 16) {
                    Group {
                        if let avatar: AvatarModel = avatarSheetVM.selectedAvatar {
                            AvatarImageView(
                                color: avatarSheetVM.selectedBackgroundColor.toColor(),
                                avatar: avatar
                            )
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(Color.secondary.gradient)
                                .symbolRenderingMode(.multicolor)
                        }
                    }
                    .clipShape(Circle())
                    .frame(width: imageSize, height: imageSize)
                    
                    VStack(alignment: .leading) {
                        Text(profileVM.anonymousName)
                            .font(.footnote.weight(.medium))
                        
                        Text("Anonymous Account")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "checkmark")
                        .opacity(profileVM.selectedAccount == .anonymous ? 1 : 0)
                }
                .padding()
                .padding(.vertical, 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(uiColor: .systemGray5), lineWidth: 1)
                )
                
                
                
            }
            .padding(.horizontal, 25)
            .padding(.top, 40)
            .geometryReaderDimensionViewModifier($contentHeight, dimension: .height)
            .presentationDragIndicator(.visible)
            .presentationBackground(.sheetbackground)
            .presentationDetents([.height(contentHeight)])
        }
    }
}

// MARK: - PREVIEWS
#Preview("Profile_SwitchProfilesSheetView") {
    Profile_SwitchProfilesSheetView()
        .previewViewModifier
}

