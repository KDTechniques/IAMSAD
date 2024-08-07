//
//  AvatarCollectionSheetFooterView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-07.
//

import SwiftUI

struct AvatarCollectionSheetFooterView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    let blurBackgroundHeight: CGFloat = 35
    let extraBlurBackgroundHeight: CGFloat = 50
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Text("Auto Color ON".uppercased())
                .font(.caption2.weight(.medium))
                .padding(5)
                .background(Color(uiColor: .systemGray5))
                .clipShape(.rect(cornerRadius: 5))
            
            Text("Tap repeatedly to change color")
                .foregroundStyle(.secondary)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom)
        .background(Color(uiColor: colorScheme == .dark ? .systemGray6 : .white))
        .background(alignment: .top) { topBackground_1 }
        .background(alignment: .top) { topBackground_2 }
    }
}

// MARK: - PREVIEWS
#Preview("AvatarCollectionSheetFooterView") {
    AvatarCollectionSheetFooterView()
        .frame(maxHeight: .infinity, alignment: .bottom)
        .previewViewModifier
}

// MARK: - EXTENSIONS
extension AvatarCollectionSheetFooterView {
    // MARK: - topBackground_1
    private var topBackground_1: some View {
        Rectangle()
            .fill(Color(uiColor: colorScheme == .dark ? .systemGray6 : .white))
            .frame(height: blurBackgroundHeight)
            .blur(radius: 3)
            .offset(y: -blurBackgroundHeight/2)
    }
    
    // MARK: - topBackground_2
    private var topBackground_2: some View {
        Rectangle()
            .fill(Color(uiColor: colorScheme == .dark ? .systemGray6 : .white))
            .frame(height: blurBackgroundHeight+extraBlurBackgroundHeight)
            .blur(radius: 30)
            .offset(y: -(blurBackgroundHeight+extraBlurBackgroundHeight)/2)
    }
}
