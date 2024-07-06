//
//  AvatarSheetHeaderTitleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-06.
//

import SwiftUI

struct AvatarSheetHeaderTitleView: View {
    // MARK: - BODY
    var body: some View {
        Text("Pick Your Avatar")
            .font(.headline)
            .frame(maxWidth: .infinity)
    }
}

// MARK: - PREVIEWS
#Preview("AvatarSheetHeaderTitleView") {
    AvatarSheetHeaderTitleView()
        .previewViewModifier
}
