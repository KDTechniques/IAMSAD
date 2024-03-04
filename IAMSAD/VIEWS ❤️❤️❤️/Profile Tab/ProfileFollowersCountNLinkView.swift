//
//  ProfileFollowersCountNLinkView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-04.
//

import SwiftUI

struct ProfileFollowersCountNLinkView: View {
    // MARK: - PROPERTIES
    
    
    
    // MARK: - INITIALIZER
    
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 5) {
            HStack(spacing: 5) {
                HStack(spacing: -8) {
                    Circle()
                        .fill(.tabBarNSystemBackground)
                        .frame(width: 20, height: 20)
                        .overlay {
                            Image(.follower1)
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .padding(1.5)
                        }
                    
                    Circle()
                        .fill(.tabBarNSystemBackground)
                        .frame(width: 20, height: 20)
                        .overlay {
                            Image(.follower2)
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .padding(1.5)
                        }
                    
                    Circle()
                        .fill(.tabBarNSystemBackground)
                        .frame(width: 20, height: 20)
                        .overlay {
                            Image(.follower3)
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .padding(1.5)
                        }
                }
                .padding(.trailing, 2)
                
                Text("69 followers")
            }
            .registerProfileTapEvent(event: .followers) {
                // followers action goes here...
                print("followers action got triggered...")
            }
            
            Circle()
                .fill(.secondary)
                .frame(width: 2, height: 2)
                .offset(y: 2)
            
            Text("kd_techniques/sleepi.com")
                .tint(.secondary)
                .registerProfileTapEvent(event: .link) {
                    // link action goes here...
                    print("link action got triggered...")
                }
        }
        .foregroundStyle(.secondary)
        .font(.subheadline)
    }
}

// MARK: - PREVIEWS
#Preview("ProfileFollowersCountNLinkView") {
    ProfileFollowersCountNLinkView()
}
