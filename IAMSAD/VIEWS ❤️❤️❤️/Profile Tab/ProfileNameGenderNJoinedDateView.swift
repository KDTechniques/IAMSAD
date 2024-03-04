//
//  ProfileNameGenderNJoinedDateView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI

struct ProfileNameGenderNJoinedDateView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var profileVM: ProfileViewModel
    
    let name: String
    let badgeType: VerifiedBadgeTypes?
    let gender: GenderTypes
    let joinedDate: String
    
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
                Text(name)
                    .font(.system(size: 24, weight: .bold))
                
                if let badgeType {
                    Image(systemName: "checkmark.seal.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 17, height: 17)
                        .fontWeight(.semibold)
                        .foregroundStyle(badgeType == .blue ? .cyan : .orange)
                }
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
            
            Text(gender.rawValue)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Label("Joined \(joinedDate)", systemImage: "calendar")
                .font(.subheadline)
                .padding(.top, 20)
        }
    }
}

// MARK: - PREVIEWS
#Preview("ProfileNameGenderNJoinedDateView") {
    ProfileNameGenderNJoinedDateView(
        name: "Deepashika Sajeewanie",
        badgeType: .orange,
        gender: .female,
        joinedDate: "June 2024"
    )
    .previewViewModifier
}
