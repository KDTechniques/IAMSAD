//
//  Conversations_ReadMoreButtonView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-10.
//

import SwiftUI

struct Conversations_ReadMoreButtonView: View {
    // MARK: - PROPERTIES
    let action: () -> Void
    
    // MARK: - INITIALIZER
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    // MARK: - BODY
    var body: some View {
        Button("Read more") { action() }
            .fontWeight(.medium)
            .padding(.bottom, 2)
    }
}

// MARK: - PREVIEWS
#Preview("Conversations_ReadMoreButtonView") {
    Conversations_ReadMoreButtonView() {
        print("Read More triggered!")
    }
}
