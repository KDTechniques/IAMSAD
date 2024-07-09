//
//  HidableDividerView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-10.
//

import SwiftUI

struct HidableDividerView: View {
    // MARK: - PROPERTIES
    let showDivider: Bool
    
    // MARK: - INITIALIZER
    init(showDivider: Bool) {
        self.showDivider = showDivider
    }
    
    // MARK: - BODY
    var body: some View {
        Divider()
            .opacity(showDivider ? 1 : 0)
    }
}

// MARK: - PREVIEWS
#Preview("HidableDividerView") {
    HidableDividerView(showDivider: true)
}
