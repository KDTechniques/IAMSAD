//
//  Profile_ArrowIconView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-07.
//

import SwiftUI

struct Profile_ArrowIconView: View {
    // MARK: - PROPERTIES
    let arrowIconAngle: CGFloat
    let arrowIconOpacity: CGFloat
    
    // MARK: - INITIAILZIER
    init(arrowIconAngle: CGFloat, arrowIconOpacity: CGFloat) {
        self.arrowIconAngle = arrowIconAngle
        self.arrowIconOpacity = arrowIconOpacity
    }
    
    // MARK: - BODY
    var body: some View {
        Image(systemName: "arrow.down")
            .resizable()
            .scaledToFit()
            .fontWeight(.medium)
            .rotationEffect(.degrees(arrowIconAngle))
            .foregroundStyle(.white)
            .opacity(arrowIconOpacity)
    }
}

// MARK: - PREVIEWS
#Preview("Profile_ArrowIconView") {
    Profile_ArrowIconView(
        arrowIconAngle: 0,
        arrowIconOpacity: 0
    )
}
