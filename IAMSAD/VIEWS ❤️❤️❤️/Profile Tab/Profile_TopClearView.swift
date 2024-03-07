//
//  Profile_TopClearView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI

@MainActor
struct Profile_TopClearView: View {
    // MARK: - PROPERTIES
    let profileVM: ProfileViewModel = .shared
    
    // MARK: - BODY
    var body: some View {
        Color.clear
            .frame(height: profileVM.coverStaticHeight)
    }
}

// MARK: - PREVIEWS
#Preview("Profile_TopClearView") {
    Profile_TopClearView()
}
