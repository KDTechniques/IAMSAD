//
//  AvatarSelectionHeaderButtonView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-06.
//

import SwiftUI

struct AvatarSelectionHeaderButtonView: View {
    // MARK: - PROPERTIES
    @Environment(AvatarSheetVM.self) private var vm
    
    // MARK: - BODY
    var body: some View {
        Button { vm.isPresentedSeeAllSheet = true } label: {
            Text("See All")
                .fontWeight(.medium)
                .padding(.horizontal, 20)
        }
    }
}

// MARK: - PREVIEWS
#Preview("AvatarSelectionHeaderButtonView") {
    AvatarSelectionHeaderButtonView()
        .previewViewModifier
}
