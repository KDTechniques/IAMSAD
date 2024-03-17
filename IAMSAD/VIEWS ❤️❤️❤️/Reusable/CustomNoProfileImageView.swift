//
//  CustomNoProfileImageView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-16.
//

import SwiftUI

struct CustomNoProfileImageView: View {
    // MARK: - BODY
    var body: some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .scaledToFit()
            .foregroundStyle(Color.secondary.gradient)
            .symbolRenderingMode(.multicolor)
    }
}

// MARK: - PREVIEWS
#Preview("CustomNoProfileImageView") {
    CustomNoProfileImageView()
}
