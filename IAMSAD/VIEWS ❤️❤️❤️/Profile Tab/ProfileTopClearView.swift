//
//  ProfileTopClearView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI

struct ProfileTopClearView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject private var profileVM: ProfileViewModel
    
    // MARK: - BODY
    var body: some View {
        Color.clear
            .frame(height: profileVM.coverPhotoFrameStaticMaxY)
    }
}

// MARK: - PREVIEWS
#Preview("ProfileTopClearView") {
    ProfileTopClearView()
}
