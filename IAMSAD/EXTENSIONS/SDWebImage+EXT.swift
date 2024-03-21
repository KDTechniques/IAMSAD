//
//  SDWebImage+EXT.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-05.
//

import SwiftUI
import SDWebImageSwiftUI

extension WebImage {
    // MARK: - defaultBColorPlaceholder()
    func defaultBColorPlaceholder(_ backgroundColor: Color = Color(uiColor: .systemGray6)) -> some View {
        self.placeholder { backgroundColor }
    }
}
