//
//  LaunchScreen.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-02-04.
//

import SwiftUI

struct LaunchScreen: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
            image
            Spacer()
            bottomText
        }
    }
}

// MARK: - PREVIEWS
#Preview("LaunchScreen") { LaunchScreen() }

extension LaunchScreen {
    // MARK: - image
    private var image: some View {
        VStack {
            Image(colorScheme == .dark ? .logoDark : .logoLight)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            ProgressView()
                .scaleEffect(0.8)
                .tint(.orange)
        }
    }
    
    // MARK: - bottomText
    private var bottomText: some View {
        VStack {
            Text("from")
                .foregroundStyle(Color(uiColor: .systemGray3))
                .font(.caption)
            
            Text("kd_techniques")
                .font(.footnote)
                .foregroundStyle(Color(uiColor: .systemGray2))
        }
    }
}
