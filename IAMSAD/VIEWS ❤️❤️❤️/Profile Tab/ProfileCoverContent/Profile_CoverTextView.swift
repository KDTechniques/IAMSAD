//
//  Profile_CoverTextView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-07.
//

import SwiftUI

@MainActor
struct Profile_CoverTextView: View {
    // MARK: - PROPERTIES
    @Binding var coverTextStaticHeight: CGFloat
    let name: String
    let subHeadlineText: String
    let topToolbarLeadingItemStaticMaxX: CGFloat
    
    let profileVM: ProfileVM = .shared
    let coverTextExtraLeadingPadding: CGFloat = 20
    let refreshBy: Any
    
    // MARK: - INITIALIZER
    init(
        coverTextStaticHeight: Binding<CGFloat>,
        name: String,
        subHeadlineText: String,
        topToolbarLeadingItemStaticMaxX: CGFloat,
        refreshBy: Any
    ) {
        self._coverTextStaticHeight = coverTextStaticHeight
        self.name = name
        self.subHeadlineText = subHeadlineText
        self.topToolbarLeadingItemStaticMaxX = topToolbarLeadingItemStaticMaxX
        self.refreshBy = refreshBy
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: -5) {
            Text(name)
                .font(.title3.weight(.heavy))
            
            Text(subHeadlineText)
                .font(.footnote)
        }
        .foregroundStyle(.white)
        .padding(.leading, topToolbarLeadingItemStaticMaxX + coverTextExtraLeadingPadding)
        .geometryReaderDimensionViewModifier($coverTextStaticHeight, dimension: .height)
        .offset(y: coverTextStaticHeight)
        .offset(y: profileVM.getCoverTextOffset())
        .opacity(profileVM.getCoverTextOpacity())
    }
}

// MARK: - PREVIEWS
#Preview("Profile_CoverTextView") {
    Profile_CoverTextView(
        coverTextStaticHeight: .constant(0),
        name: "Preview Name",
        subHeadlineText: "preview sub-headline text",
        topToolbarLeadingItemStaticMaxX: 0,
        refreshBy: 0
    )
}
