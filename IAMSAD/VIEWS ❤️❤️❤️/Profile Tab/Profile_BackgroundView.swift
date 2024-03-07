//
//  Profile_BackgroundView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI

struct Profile_BackgroundView: View {
    // MARK: - BODY
    var body: some View {
        Color.tabBarNSystemBackground
            .ignoresSafeArea()
    }
}

// MARK: - PREVIEWS
#Preview("Profile_BackgroundView") {
    Profile_BackgroundView()
}
