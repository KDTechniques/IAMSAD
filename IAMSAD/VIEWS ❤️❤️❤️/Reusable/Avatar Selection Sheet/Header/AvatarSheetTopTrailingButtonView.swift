//
//  AvatarSheetTopTrailingButtonView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-06.
//

import SwiftUI

struct AvatarSheetTopTrailingButtonView: View {
    // MARK: - PROPERTIERS
    @Environment(AvatarSheetVM.self) private var vm
    
    // MARK: - BODY
    var body: some View {
        Button { vm.isPresentedAvatarSheet = false } label: {
            Text("Done")
                .fontWeight(.semibold)
                .padding()
        }
    }
}

#Preview("AvatarSheetTopTrailingButtonView") {
    AvatarSheetTopTrailingButtonView()
        .previewViewModifier
}
