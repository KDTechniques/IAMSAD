//
//  AvatarBackgroundColorSelectionHeaderTextView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-06-27.
//

import SwiftUI

struct AvatarBackgroundColorSelectionHeaderTextView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    private var sectionHeaderColor: Color {
        colorScheme == .dark ? Color(uiColor: .lightGray) : Color(uiColor: .darkGray)
    }
    
    // MARK: - BODY
    var body: some View {
        Text("Background Color")
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(sectionHeaderColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - PREVIEWS
#Preview("AvatarBackgroundColorSelectionHeaderTextView") {
    AvatarBackgroundColorSelectionHeaderTextView()
        .previewViewModifier
}
