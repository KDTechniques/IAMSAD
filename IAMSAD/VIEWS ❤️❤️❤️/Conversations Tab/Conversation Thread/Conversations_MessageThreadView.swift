//
//  Conversations_MessageThreadView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-09.
//

import SwiftUI

struct Conversations_MessageThreadView: View {
    
    @State private var toggle: Bool = !false
    
    var body: some View {
        Color.black.ignoresSafeArea()
            .overlay {
                Image(.whatsappchatbackgroundimage)
                    .resizable()
                    .scaledToFill()
                    .opacity(0.2)
                    .ignoresSafeArea()
            }
            .overlay {
                let padding: CGFloat = 12
                Conversations_RegularMessageBubbleView(direction: toggle ? .left : .right) {
                    Text("This is a sample, and bit longer text that could go up to two lines.This is a sample, and bit longer text that could go up to two lines.This is a sample, and bit longer text that could go up to two lines.")
                        .lineLimit(60)
                        .padding(padding)
                        .overlay(alignment: .bottomTrailing) {
                            Text("10:43 PM")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                                .padding(.trailing, padding)
                                .padding(.bottom, 10)
                        }
                    
                }
                .onTapGesture {
                    toggle.toggle()
                }
            }
    }
}

#Preview("Conversations_MessageThreadView") {
    Conversations_MessageThreadView()
}
