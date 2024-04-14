//
//  Conversations_GIFBadgeView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-14.
//

import SwiftUI

struct Conversations_GIFBadgeView: View {
    // MARK: - PROPERTIES
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    let values = MessageBubbleValues.self
    var height: CGFloat { values.mediaTypeFontHeight(dynamicTypeSize) - 3 }
    var ratio: CGFloat { height / 33 }
    var fontSize: CGFloat { ratio * 20 }
    var width: CGFloat { ratio * 48 }
    var cornerRadius: CGFloat { ratio * 10 }
    var offsetX: CGFloat { ratio * 1.3 }
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: values.mediaTypeIconToTextHPadding) {
            Text("GIF")
                .font(.system(size: fontSize).weight(.bold))
                .fontDesign(.rounded)
                .foregroundStyle(.black)
                .frame(width: width, height: height)
                .offset(x: offsetX)
                .background(.gray)
                .clipShape(.rect(cornerRadius: cornerRadius))
            
            Conversations_MediaBadgeTextView(text: "GIF")
        }
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_GIFBadgeView") {
    Conversations_GIFBadgeView()
        .previewViewModifier
}
