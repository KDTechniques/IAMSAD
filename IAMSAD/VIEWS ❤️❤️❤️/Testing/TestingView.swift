//
//  TestingView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-03-10.
//

import SwiftUI

struct TestingView: View {
    
    @EnvironmentObject var profileVM: ProfileViewModel
    
    @State var contentOffset: CGPoint = .zero
    @State var array: [Int] = Array(0...100)
    
    var body: some View {
        CustomUIScrollView(.vertical, contentOffset: $profileVM.contentOffset) {
            LazyVStack {
                ForEach(array, id: \.self) { index in
                    Button(index.description) {
                        let last = array.last!
                        array.append(last+1)
                        profileVM.bioText = ""
                    }
                    .frame(width: screenWidth)
                }
                .padding(.top)
            }
        }
    }
}

#Preview {
    TestingView()
        .previewViewModifier
}
