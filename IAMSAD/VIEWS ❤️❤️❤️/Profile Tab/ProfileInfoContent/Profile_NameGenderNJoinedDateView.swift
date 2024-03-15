//
//  Profile_NameGenderNJoinedDateView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI

@MainActor
struct Profile_NameGenderNJoinedDateView: View {
    // MARK: - PROPERTIES
    let name: String
    let badgeType: VerifiedBadgeTypes?
    let gender: GenderTypes
    let joinedDate: String
    
    let profileVM: ProfileVM = .shared
    
    // MARK: - INITIALIZER
    init(name: String, badgeType: VerifiedBadgeTypes?, gender: GenderTypes, joinedDate: String) {
        self.name = name
        self.badgeType = badgeType
        self.gender = gender
        self.joinedDate = joinedDate
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                nameText
                badge
            }
            .background {
                GeometryReader { geo in
                    Color.clear
                        .preference(key: CustomCGFloatPreferenceKey.self, value: geo.frame(in: .global).minY)
                        .onPreferenceChange(CustomCGFloatPreferenceKey.self) {
                            profileVM.setCoverTextOffsetY($0)
                        }
                }
            }
            
            genderText
            joinedDateText
        }
    }
}

// MARK: - PREVIEWS
#Preview("Profile_NameGenderNJoinedDateView") {
    Profile_NameGenderNJoinedDateView(
        name: "Preview Name",
        badgeType: .blue,
        gender: .male,
        joinedDate: "January 2024"
    )
    .previewViewModifier
}

extension Profile_NameGenderNJoinedDateView {
    // MARK: - name
    private var nameText: some View {
        Text(name)
            .font(.system(size: 24, weight: .bold))
    }
    
    // MARK: - badge
    @ViewBuilder
    private var badge: some View {
        if let badgeType = badgeType {
            Image(systemName: "checkmark.seal.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 17, height: 17)
                .fontWeight(.semibold)
                .foregroundStyle(badgeType == .blue ? .cyan : .orange)
        }
    }
    
    // MARK: - gender
    private var genderText: some View {
        Text(gender.rawValue)
            .font(.subheadline)
            .foregroundStyle(.secondary)
    }
    
    // MARK: - joinedDate
    private var joinedDateText: some View {
        Label("Joined \(joinedDate)", systemImage: "calendar")
            .font(.subheadline)
            .padding(.top, 20)
    }
}
