//
//  ProfileNameGenderNJoinedDateView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI

struct ProfileNameGenderNJoinedDateView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var profileNameGenderNJoinedDateVM: ProfileNameGenderNJoinedDateVM
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                name
                badge
            }
            .background {
                GeometryReader { geo in
                    Color.clear
                        .preference(key: CustomCGFloatPreferenceKey.self, value: geo.frame(in: .global).minY)
                        .onPreferenceChange(CustomCGFloatPreferenceKey.self) {
                            ProfileCoverVM.shared.setCoverTextOffsetY($0)
                        }
                }
            }
            
            gender
            joinedDate
        }
//        .background(Color.debug)
    }
}

// MARK: - PREVIEWS
#Preview("ProfileNameGenderNJoinedDateView") {
    ProfileNameGenderNJoinedDateView()
        .previewViewModifier
}

extension ProfileNameGenderNJoinedDateView {
    // MARK: - name
    private var name: some View {
        Text(profileNameGenderNJoinedDateVM.name)
            .font(.system(size: 24, weight: .bold))
    }
    
    // MARK: - badge
    @ViewBuilder
    private var badge: some View {
        if let badgeType = profileNameGenderNJoinedDateVM.badgeType {
            Image(systemName: "checkmark.seal.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 17, height: 17)
                .fontWeight(.semibold)
                .foregroundStyle(badgeType == .blue ? .cyan : .orange)
        }
    }
    
    // MARK: - gender
    private var gender: some View {
        Text(profileNameGenderNJoinedDateVM.gender.rawValue)
            .font(.subheadline)
            .foregroundStyle(.secondary)
    }
    
    // MARK: - joinedDate
    private var joinedDate: some View {
        Label("Joined \(profileNameGenderNJoinedDateVM.joinedDate)", systemImage: "calendar")
            .font(.subheadline)
            .padding(.top, 20)
    }
}
