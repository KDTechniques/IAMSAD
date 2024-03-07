//
//  ProfileView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-09.
//

import SwiftUI
import Combine

struct ProfileView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var profileVM: ProfileViewModel
    
    let maxArrowOpacityCoverHeight: CGFloat = 10 // remove later
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Profile_BackgroundView()
                
                Profile_InfoView()
                
                Testing123(
                    contentOffset: $profileVM.contentOffset,
                    tapCoordinates: $profileVM.tapCoordinates,
                    topContentHeight: profileVM.profileContentHeight
                )
                
                Profile_CoverContentView()
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }
}

// MARK: - PREVIEWS
#Preview("ProfileView") {
    ProfileView()
        .previewViewModifier
}
