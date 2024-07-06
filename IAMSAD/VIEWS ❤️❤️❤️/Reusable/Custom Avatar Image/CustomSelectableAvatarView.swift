//
//  CustomSelectableAvatarView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-10.
//

import SwiftUI

struct CustomSelectableAvatarView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var selectedAvatar: AvatarModel?
    @Binding var dynamicColor: ColorPaletteModel
    let avatar: AvatarModel
    let staticColor: Color
    let isAutoColorOn: Bool
    let withBorder: Bool
    
    // MARK: - INITIALIZER
    init(
        selectedAvatar: Binding<AvatarModel?>,
        dynamicColor: Binding<ColorPaletteModel> = .constant(.init(
            hue: 0,
            saturation: 0,
            brightness: 0
        )), // => white
        avatar: AvatarModel,
        staticColor: Color = .white,
        isAutoColorOn: Bool = false,
        withBorder: Bool = true
    ) {
        _selectedAvatar = selectedAvatar
        _dynamicColor = dynamicColor
        self.avatar = avatar
        self.isAutoColorOn = isAutoColorOn
        self.staticColor = selectedAvatar.wrappedValue == avatar ? staticColor : .white
        self.withBorder = withBorder
    }
    
    // MARK: - BODY
    var body: some View {
        AvatarImageView(color: staticColor, avatar: avatar, showBorder: withBorder)
            .padding(5)
            .background(
                Circle()
                    .strokeBorder(.accent, style: .init(
                        lineWidth: 2.5,
                        lineCap: .round,
                        lineJoin: .round
                    ))
                    .opacity(selectedAvatar == avatar ? 1 : 0)
            )
            .onTapGesture { handleTap() }
    }
}

// MARK: - PREVIEWS
#Preview("CustomSelectableAvatarView") {
    @Previewable @State var selectedAvatar: AvatarModel? = Avatar.shared.publicAvatarsArray[2]
    
    HStack {
        ForEach(0..<5, id: \.self) { /// From Featured Collection
            CustomSelectableAvatarView(
                selectedAvatar: $selectedAvatar,
                avatar: Avatar.shared.publicAvatarsArray[$0]
            )
            .frame(width: 70, height: 70)
        }
    }
    .previewViewModifier
}

// MARK: - EXTENSIONS
@MainActor
extension CustomSelectableAvatarView {
    // MARK: - handleTap
    private func handleTap() {
        withAnimation(.smooth) { selectedAvatar = avatar }
        
        if isAutoColorOn {
            let color: ColorPaletteModel = .init(
                hue: Color.defaultAvatarColorPaletteArray
                    .randomElement()?
                    .hue ?? .zero,
                saturation: Double.random(in: 0.5...0.7),
                brightness: 1.0
            )
            
            withAnimation { dynamicColor = color }
            
            HapticFeedbackGenerator().vibrate(type: .selection)
        }
    }
}
