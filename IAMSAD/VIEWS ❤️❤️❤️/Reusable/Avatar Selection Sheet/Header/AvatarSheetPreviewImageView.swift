//
//  AvatarSheetPreviewImageView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-07.
//

import SwiftUI

struct AvatarSheetPreviewImageView: View {
    // MARK: - PROPERTIES
    @Environment(AvatarSheetVM.self) private var vm
    
    let imageFrameSize: CGFloat = 80
    
    // MARK: - BODY
    var body: some View {
        CustomAvatarView(
            avatar: vm.selectedAvatar,
            imageSize: imageFrameSize,
            color: Color(
                hue: vm.selectedBackgroundColor.hue,
                saturation: vm.selectedBackgroundColor.saturation,
                brightness: vm.selectedBackgroundColor.brightness
            )
        )
        .padding()
    }
}

// MARK: - PREVIEWS
#Preview("AvatarSheetPreviewImageView") {
    AvatarSheetPreviewImageView()
        .previewViewModifier
}
