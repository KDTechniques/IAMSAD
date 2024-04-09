//
//  Conversations_MessageThreadView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-09.
//

import SwiftUI

struct Conversations_MessageThreadView: View {
    
    @State private var toggle: Bool = false
    @State private var isExceededLineLimit: Bool = false
    @State private var isReadMore: Bool = false
    @State private var height: CGFloat = 0
    
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
                ScrollView(.vertical) {
                    let padding: CGFloat = 12
                    let text: String = "This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines.This is a sample, and bit longer text that could go up to several lines."
                    
                    Conversations_RegularMessageBubbleView(direction: toggle ? .left : .right) {
                        VStack(spacing: 10) {
                            if !isReadMore {
                                if height < screenHeight {
                                    Text(text)
                                        .geometryReaderDimensionViewModifier($height, dimension: .height)
                                } else {
                                    Text(text)
                                        .lineLimit(50)
                                        .onAppear { isExceededLineLimit = true }
                                        .onDisappear { isExceededLineLimit = false }
                                }
                            } else {
                                Text(text)
                            }
                            
                            HStack(alignment: .bottom) {
                                if isExceededLineLimit {
                                    Button("Read more") { isReadMore = true }
                                        .fontWeight(.medium)
                                        .padding(.bottom, 4)
                                }
                                
                                Spacer()
                                
                                Text("10:43 PM")
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding([.horizontal, .top], padding)
                        .padding(.bottom, 6)
                    }
                    .onTapGesture { toggle.toggle() }
                }
            }
    }
}

#Preview("Conversations_MessageThreadView") {
    Conversations_MessageThreadView()
}
