//
//  ProfileView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-09.
//

import SwiftUI

struct ProfileView: View {
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Profile_BackgroundView()
                Profile_InfoView()
                Profile_TabContentsView()
                Profile_CoverContentView()
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            .onAppear { ProfileVM.shared.handleSafeSubscribing() }
        }
    }
}

// MARK: - PREVIEWS
#Preview("ProfileView") {
    ProfileView()
        .previewViewModifier
}


// person.badge.shield.checkmark.fill
