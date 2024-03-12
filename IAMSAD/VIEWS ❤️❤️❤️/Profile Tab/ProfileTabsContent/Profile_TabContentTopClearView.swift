//
//  Profile_TabContentTopClearView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-12.
//

import SwiftUI

struct Profile_TabContentTopClearView: View {
    // MARK: - PROPERTIES
    let topContentHeight: CGFloat
    let horizontalTabHeight: CGFloat
    
    var frameHeight: CGFloat { topContentHeight + horizontalTabHeight }
    
    // MARK: - BODY
    var body: some View {
        Color.clear
            .frame(height: frameHeight > 0 ? frameHeight : .zero)
            .background {
                GeometryReader { geo in
                    Color.clear
                        .preference(
                            key: CustomCGFloatPreferenceKey.self,
                            value: geo.frame(in: .global).minY
                        )
                        .onPreferenceChange(CustomCGFloatPreferenceKey.self) { value in
                            let profileVM: ProfileViewModel = .shared
                            let conditionValue: CGFloat = topContentHeight -
                            profileVM.coverStaticHeight -
                            profileVM.coverMaxExtraHeight
                            
                            profileVM.contentOffset.y = -value < conditionValue
                            ? -value
                            : conditionValue
                        }
                }
            }
    }
}

// MARK: - PREVIEWS
#Preview("Profile_TabContentTopClearView") {
    Profile_TabContentTopClearView(topContentHeight: 400, horizontalTabHeight: 100)
}
