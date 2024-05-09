//
//  Conversations_ForwardedTextView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-01.
//

import SwiftUI

struct Conversations_ForwardedTextView: View {
    // MARK: - PROPERTIES
    let values = MessageBubbleValues.self
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 5) {
            Image(.forwarded)
                .renderingMode(.template)
            
            Text("Forwarded")
                .italic()
                .font(.footnote)
        }
        
        .foregroundStyle(.secondary)
        .padding(.leading, values.innerHPadding)
        .padding(.top, values.innerVPadding)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_ForwardedTextView") {
    Conversations_ForwardedTextView()
        .previewViewModifier
}
