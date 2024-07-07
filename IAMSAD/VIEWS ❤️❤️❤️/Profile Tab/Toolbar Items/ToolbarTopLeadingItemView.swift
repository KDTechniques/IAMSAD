//
//  ToolbarTopLeadingItemView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-26.
//

import SwiftUI

struct ToolbarTopLeadingItemView: View {
    // MARK: - PROPERTIES
    @Binding var topToolbarLeadingItemStaticMaxX: CGFloat
    let iconFrameSize: CGFloat
    let buttonType: ProfileTabTopLeadingToolbarButtonTypes?
    
    // MARK: - INITIALIZER
    init(
        topToolbarLeadingItemStaticMaxX: Binding<CGFloat>,
        iconFrameSize: CGFloat,
        buttonType: ProfileTabTopLeadingToolbarButtonTypes? = nil
    ) {
        self._topToolbarLeadingItemStaticMaxX = topToolbarLeadingItemStaticMaxX
        self.buttonType = buttonType
        self.iconFrameSize = iconFrameSize
    }
    
    // MARK: - BODY
    var body: some View {
        Button {
            // back/lock button action goes here...
        } label: {
            switch buttonType {
            case .backButton, .lockButton:
                Image(systemName: buttonType == .backButton ? "arrow.left" : "lock.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconFrameSize, height: iconFrameSize)
                    .padding(9)
                    .background(.black.opacity(0.6))
                    .clipShape(Circle())
                    .background {
                        GeometryReader { geo in
                            Color.clear
                                .preference(
                                    key: CustomCGFloatPreferenceKey.self,
                                    value: geo.frame(in: .global).maxX
                                )
                                .onPreferenceChange(CustomCGFloatPreferenceKey.self) {
                                    topToolbarLeadingItemStaticMaxX = $0
                                }
                        }
                    }
                
            case nil:
                EmptyView()
            }
        }
        .fontWeight(.semibold)
        .tint(.white)
    }
}

// MARK: - PREVIEW
#Preview("ToolbarTopLeadingItemView") {
    NavigationStack {
        Color.clear
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    ToolbarTopLeadingItemView(
                        topToolbarLeadingItemStaticMaxX: .constant(0),
                        iconFrameSize: 14,
                        buttonType: .lockButton
                    )
                }
            }
    }
}

enum ProfileTabTopLeadingToolbarButtonTypes {
    case backButton, lockButton
}
