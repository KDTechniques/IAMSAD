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
                Profile_TabContentsView()
                Profile_CoverContentView()
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            .onTapGesture { handleTap($0) }
        }
    }
}

// MARK: - PREVIEWS
#Preview("ProfileView") {
    ProfileView()
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension ProfileView {
    // MARK: - FUNCTIONS
    
    //  MARK: - handleTap
    /// Handles all touch gestures for the profile tab view.
    /// Uses the profileVM class to manage touch events and register untouchable events in an array.
    /// The untouchable events are specified using a model.
    /// Checks the array when a tap occurs and executes relevant actions.
    private func handleTap(_ coordinates: CGPoint) {
        profileVM.tapCoordinates = coordinates
    }
}
