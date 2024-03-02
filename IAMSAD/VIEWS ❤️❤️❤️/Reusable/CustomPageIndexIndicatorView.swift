//
//  CustomPageIndexIndicatorView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-10.
//

import SwiftUI

struct CustomPageIndexIndicatorView<T: Hashable>: View {
    // MARK: - PROPERTIES
    @Binding var selectedItem: T
    let itemTypesArray: [T]
    
    // MARK: - BODY
    var body: some View {
        Picker("", selection: $selectedItem) {
            ForEach(itemTypesArray, id: \.self) { _ in
                Circle()
                    .fill(.secondary)
                    .frame(width: 10)
            }
        }
        .pickerStyle(.wheel)
        .frame(width: 40)
        .scaleEffect(0.8)
        .rotationEffect(.degrees(-90))
        .animation(.default, value: selectedItem)
    }
}

// MARK: - PREVIEWS
#Preview("CustomPageIndexIndicatorView") {
    CustomPageIndexIndicatorView(selectedItem: .constant(4), itemTypesArray: [1,2,3,4,5,6,7,8])
        .previewViewModifier
}
