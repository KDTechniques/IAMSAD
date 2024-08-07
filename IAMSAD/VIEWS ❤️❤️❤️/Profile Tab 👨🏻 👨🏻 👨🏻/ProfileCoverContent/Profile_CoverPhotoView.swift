//
//  Profile_CoverPhotoView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-07.
//

import SwiftUI
import SDWebImageSwiftUI

struct Profile_CoverPhotoView: View {
    // MARK: - PROPERTIES
    let coverPhotoURL: URL?
    
    // MARK: - INITIALIZER
    init(coverPhotoURL: URL?) {
        self.coverPhotoURL = coverPhotoURL
    }
    
    // MARK: - BODY
    var body: some View {
        WebImage(
            url: coverPhotoURL,
            options: [.scaleDownLargeImages, .retryFailed, .progressiveLoad]
        ) { $0 } placeholder: {
            Color.defaultBColorPlaceholder()
        }
        .resizable()
        .scaledToFill()
        .allowsHitTesting(false)
    }
}

// MARK: PREVIEW
#Preview("Profile_CoverPhotoView") {
    Profile_CoverPhotoView(coverPhotoURL: .init(string: "https://www.tomerazabi.com/wp-content/uploads/2020/12/IMG_7677-7751-1000px-SJPEG-V3.jpg"))
        .frame(height: 150)
        .clipped()
        .ignoresSafeArea()
}
