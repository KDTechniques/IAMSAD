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
            options: [.highPriority, .scaleDownLargeImages]
        )
        .resizable()
        .defaultBColorPlaceholder
        .scaledToFill()
    }
}

// MARK: PREVIEW
#Preview("Profile_CoverPhotoView") {
    Profile_CoverPhotoView(coverPhotoURL: .init(string: "https://scontent.fcmb12-1.fna.fbcdn.net/v/t39.30808-6/428378921_1244897360247264_364892912709717832_n.jpg?stp=cp6_dst-jpg&_nc_cat=107&ccb=1-7&_nc_sid=783fdb&_nc_eui2=AeH7JFeN8qN22XlIyzzLGuBEO2wghYP6jM07bCCFg_qMzQ8uHwV4d6og5_TjSTKSD6tKsW-7cTrD_1PggLl5aIzX&_nc_ohc=8d-xKDes9ssAX-JCgn6&_nc_zt=23&_nc_ht=scontent.fcmb12-1.fna&oh=00_AfBn2lcCI3RxToCyWDuiygGmueeN0Yp7RslK5JqbmCBuXQ&oe=65EBA772"))
}
