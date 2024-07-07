//
//  AvatarCollectionSheetDividerView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-07.
//

import SwiftUI

struct AvatarCollectionSheetDividerView: View {
    // MARK: - PROPERTIES
    let minY: CGFloat
    
    // MARK: - INITIALIZER
    init(minY: CGFloat) {
        self.minY = minY
    }
    
    // MARK: - PRIVATE PROPERTIES
    @State private var maxY: CGFloat = 0
    @State private var showDivider: Bool = false
    
    // MARK: - BODY
    var body: some View {
        Divider()
            .topPartBackgroundEffectOnScrollViewModifier(
                bottomPartMinY: minY,
                topPartMaxY: $maxY,
                showBackgroundEffect: $showDivider
            )
            .opacity(showDivider ? 1 : 0)
            .onChange(of: minY) { showDivider = maxY > $1 }
    }
}

// MARK: - PREVIEWS
#Preview("AvatarCollectionSheetDividerView") {
    AvatarCollectionSheetDividerView(minY: 0)
}
