//
//  StandardMediaCircularProgress_ArrowDownView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-15.
//

import SwiftUI

struct StandardMediaCircularProgress_ArrowDownView: View {
    // MARK: - PROPERTIES
    let arrowDownSize: CGFloat = 14
    
    // MARK: - BODY
    var body: some View {
        Image(systemName: "arrow.down")
            .resizable()
            .scaledToFit()
            .frame(width: arrowDownSize, height: arrowDownSize)
            .fontWeight(.semibold)
            .foregroundStyle(.arrowDown)
    }
}

// MARK: - PREVIEWS
#Preview("StandardMediaCircularProgress_ArrowDownView") {
    StandardMediaCircularProgress_ArrowDownView()
}
