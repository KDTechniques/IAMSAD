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
                print($0)
                /// take care of all the touch gesture from here...
                /// to  do that create a separate class to handle touch gestures on profile tab view.
                /// register all the untouchable events in one array using that Model created previously.
                /// then check the array when tap occurs and execute where relevant.
                /// don't for get to create a property to disable touch executions when ever needed.
                /// for example, if a popup occurs on the view, disable touch executions until the popup dismisses, other wise eve though you click on a button on the popup, a button on the bottom get executed unnecessarily.
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("ProfileView") {
    ProfileView()
        .previewViewModifier
}
