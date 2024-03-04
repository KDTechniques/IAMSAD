//
//  ProfileBackgroundView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI

struct ProfileBackgroundView: View {
    // MARK: - BODY
    var body: some View {
        Color.tabBarNSystemBackground
            .ignoresSafeArea()
    }
}

// MARK: - PREVIEWS
#Preview("ProfileBackgroundView") {
    ProfileBackgroundView()
}
