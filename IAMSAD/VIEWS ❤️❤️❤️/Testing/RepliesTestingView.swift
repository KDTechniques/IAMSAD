//
//  Testing.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-05.
//

import SwiftUI
import SDWebImageSwiftUI

struct RepliesTestingView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(1...5, id: \.self) { index in
                HStack(alignment: .top) {
                    VStack {
                        CustomAvatarImageView(avatar: .init(
                            imageName: "Featured_\(index)",
                            collection: .featured,
                            position: .bottom
                        ))
                        .frame(width: 50, height: 50)
                        
                        Capsule()
                            .fill(.secondary)
                            .frame(width: 1)
                    }
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 4) {
                            Text("Elon Musk")
                                .fontWeight(.semibold)
                            
                            Text("@ElonMusk")
                                .foregroundStyle(.secondary)
                            
                            Circle()
                                .fill(.secondary)
                                .frame(width: 2, height: 2)
                            
                            HStack {
                                Text("1d")
                                    .foregroundStyle(.secondary)
                                
                                Spacer()
                                
                                HStack(spacing: 2) {
                                    ForEach(1...3, id: \.self) { _ in
                                        Circle()
                                            .fill(.secondary)
                                            .frame(width: 2, height: 2)
                                    }
                                }
                            }
                        }
                        
                        Text(UUID().uuidString+UUID().uuidString+UUID().uuidString)
                            .fontWeight(.light)
                    }
                }
            }
            
            HStack {
                VStack(spacing: 2) {
                    ForEach(1...3, id: \.self) { _ in
                        Circle()
                            .fill(.secondary)
                            .frame(width: 2, height: 2)
                    }
                }
                .frame(width: 50)
                
                Button("Show Replies") {  }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .font(.subheadline)
    }
}

#Preview {
    RepliesTestingView()
}
