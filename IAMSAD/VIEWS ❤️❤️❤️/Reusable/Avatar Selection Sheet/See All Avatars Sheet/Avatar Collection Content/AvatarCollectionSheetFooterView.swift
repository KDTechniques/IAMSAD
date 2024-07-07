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
    
    @Binding var footerHeight: CGFloat
    
    // MARK: - INITIALIZER
    init(footerHeight: Binding<CGFloat>) {
        _footerHeight = footerHeight
    }
    
    // MARK: - BODY
    var body: some View {
        let blurBackgroundHeight: CGFloat = 35
        let extraBlurBackgroundHeight: CGFloat = 50
        
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
        .background(alignment: .top) {
            Rectangle()
                .fill(Color(uiColor: colorScheme == .dark ? .systemGray6 : .white))
                .frame(height: blurBackgroundHeight)
                .blur(radius: 3)
                .offset(y: -blurBackgroundHeight/2)
        }
        .background(alignment: .top) {
            Rectangle()
                .fill(Color(uiColor: colorScheme == .dark ? .systemGray6 : .white))
                .frame(height: blurBackgroundHeight+extraBlurBackgroundHeight)
                .blur(radius: 30)
                .offset(y: -(blurBackgroundHeight+extraBlurBackgroundHeight)/2)
        }
        .geometryReaderDimensionViewModifier($footerHeight, dimension: .height, extraValue: 25)
    }
}

// MARK: - PREVIEWS
#Preview("AvatarCollectionSheetFooterView") {
    AvatarCollectionSheetFooterView(footerHeight: .constant(0))
        .frame(maxHeight: .infinity, alignment: .bottom)
        .previewViewModifier
}
