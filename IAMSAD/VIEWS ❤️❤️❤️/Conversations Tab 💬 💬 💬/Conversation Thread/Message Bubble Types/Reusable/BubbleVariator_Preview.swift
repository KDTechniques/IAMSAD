//
//  BubbleVariator_Preview.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-10-01.
//

import SwiftUI

struct BubbleVariator_Preview<T: View>: View {
    // MARK: - PROPERTIES
    let content: (Bool) -> T
    
    // MARK: - PRIVATE PROPERTIES
    @State private var boolean: Bool = true
    
    // MARK: - INTIALAIZER
    init(@ViewBuilder content: @escaping (Bool) -> T) {
        self.content = content
    }
    
    // MARK: - BODY
    var body: some View {
        
        ZStack {
            Color.conversationBackground
            
            Image(.whatsappchatbackgroundimage)
                .resizable()
                .scaledToFill()
                .frame(width: screenWidth, height: screenHeight)
                .opacity(0.25)
            
            content(boolean)
        }
        .overlay(alignment: .bottom) {
            Button("Random") {
                boolean.toggle()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.mini)
            .padding(.bottom, 50)
        }
        .ignoresSafeArea()
    }
}

//  MARK: - PREVIEWS
#Preview("BubbleVariator_Preview") {
    BubbleVariator_Preview { boolean in
        Text("Bool: \(boolean)")
    }
}
