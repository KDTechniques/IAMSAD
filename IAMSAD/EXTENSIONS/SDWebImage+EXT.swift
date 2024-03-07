//
//  SDWebImage+EXT.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-05.
//

import SwiftUI
import SDWebImageSwiftUI

extension WebImage {
    // MARK: - defaultBColorPlaceholder
    var defaultBColorPlaceholder: some View {
        self.placeholder { Color(uiColor: .systemGray6) }
    }
}
