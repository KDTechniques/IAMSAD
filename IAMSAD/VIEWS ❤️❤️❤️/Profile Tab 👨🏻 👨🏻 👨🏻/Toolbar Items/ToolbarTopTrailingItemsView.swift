//
//  ToolbarTopTrailingItemsView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-26.
//

import SwiftUI

struct ToolbarTopTrailingItemsView: View {
    // MARK: - PROPERTIES
    @Binding var topToolbarStaticMidY: CGFloat
    @Binding var topToolbarStaticMaxY: CGFloat
    let iconFrameSize: CGFloat
    let buttonType: ProfileTabTopTrailingToolbarButtonTypes
    
    // MARK: - INITILAIZER
    init(
        topToolbarStaticMidY: Binding<CGFloat>,
        topToolbarStaticMaxY: Binding<CGFloat>,
        iconFrameSize: CGFloat,
        buttonType: ProfileTabTopTrailingToolbarButtonTypes
    ) {
        self._topToolbarStaticMidY = topToolbarStaticMidY
        self._topToolbarStaticMaxY = topToolbarStaticMaxY
        self.iconFrameSize = iconFrameSize
        self.buttonType = buttonType
    }
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 2) {
            // MARK: Search Button
            Button {
                // search button action goes here...
            } label: {
                Image(.search)
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconFrameSize, height: iconFrameSize)
                    .padding(9)
                    .background(.black.opacity(0.5))
                    .clipShape(Circle())
                    .background {
                        GeometryReader { geo in
                            Color.clear
                                .preference(
                                    key: CustomCGRectPreferenceKey.self,
                                    value: geo.frame(in: .global)
                                )
                                .onPreferenceChange(CustomCGRectPreferenceKey.self) {
                                    topToolbarStaticMidY = $0.midY
                                    topToolbarStaticMaxY = $0.maxY
                                }
                        }
                    }
            }
            
            // MARK: Settings/More Buttons
            NavigationLink {
                Profile_SettingsView()
            } label: {
                Image(systemName: buttonType == .settingsButton ? "gearshape" : "ellipsis")
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconFrameSize, height: iconFrameSize)
                    .padding(9)
                    .background(.black.opacity(0.5))
                    .clipShape(Circle())
            }
        }
        .fontWeight(.semibold)
        .tint(.white)
    }
}

// MARK: - PREVIEWS
#Preview("ToolbarTopTrailingItemsView") {
    NavigationStack {
        Color.clear
            .frame(width: screenWidth, height: screenHeight)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    ToolbarTopTrailingItemsView(
                        topToolbarStaticMidY: .constant(.zero),
                        topToolbarStaticMaxY: .constant(.zero),
                        iconFrameSize: 14,
                        buttonType: .settingsButton
                    )
                }
            }
    }
}

enum ProfileTabTopTrailingToolbarButtonTypes {
    case settingsButton, moreButton
}
