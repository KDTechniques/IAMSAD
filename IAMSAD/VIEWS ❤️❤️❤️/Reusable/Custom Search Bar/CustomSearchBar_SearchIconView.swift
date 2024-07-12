//
//  CustomSearchBar_SearchIconView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-12.
//

import SwiftUI

struct CustomSearchBar_SearchIconView: View {
    // MARK: - BODY
    var body: some View {
        Image(systemName: "magnifyingglass")
            .foregroundColor(.searchBarIcons)
    }
}

// MARK: - PREVIEWS
#Preview("CustomSearchBar_SearchIconView") {
    CustomSearchBar_SearchIconView()
        .previewViewModifier
}
