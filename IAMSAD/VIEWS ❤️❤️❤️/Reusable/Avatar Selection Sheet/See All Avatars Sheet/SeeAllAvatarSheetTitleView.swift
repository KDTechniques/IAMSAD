//
//  SeeAllAvatarSheetTitleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-07.
//

import SwiftUI

struct SeeAllAvatarSheetTitleView: View {
    // MARK: - BODY
    var body: some View {
        Text("Avatars")
            .font(.largeTitle.bold())
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
    }
}

// MARK: - PREVIEWS
#Preview("SeeAllAvatarSheetTitleView") {
    SeeAllAvatarSheetTitleView()
}
