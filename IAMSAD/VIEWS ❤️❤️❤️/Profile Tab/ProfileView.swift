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
            .onTapGesture {
                /// Handles all touch gestures for the profile tab view.
                /// Uses the profileVM class to manage touch events and register untouchable events in an array.
                /// The untouchable events are specified using a model.
                /// Checks the array when a tap occurs and executes relevant actions.
                profileVM.tapCoordinates = $0
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("ProfileView") {
    ProfileView()
        .previewViewModifier
}
