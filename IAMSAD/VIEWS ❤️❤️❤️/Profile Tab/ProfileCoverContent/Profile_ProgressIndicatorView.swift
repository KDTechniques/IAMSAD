//
//  Profile_ProgressIndicatorView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-07.
//

import SwiftUI

struct Profile_ProgressIndicatorView: View {
    // MARK: - PROPERTIES
    let progressIndicatorOpacity: CGFloat
    
    // MARK: - INITIALIZER
    init(progressIndicatorOpacity: CGFloat) {
        self.progressIndicatorOpacity = progressIndicatorOpacity
    }
    
    // MARK: - BODY
    var body: some View {
        ProgressView()
            .tint(.white)
            .opacity(progressIndicatorOpacity)
    }
}

// MARK: - PREVIEWS
#Preview("Profile_ProgressIndicatorView") {
    Profile_ProgressIndicatorView(progressIndicatorOpacity: 0)
}
