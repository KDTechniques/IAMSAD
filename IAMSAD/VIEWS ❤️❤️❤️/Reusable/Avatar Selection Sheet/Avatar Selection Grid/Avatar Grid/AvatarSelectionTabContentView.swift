//
//  AvatarSelectionTabContentView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-07.
//

import SwiftUI

struct AvatarSelectionTabContentView: View {
    // MARK: - PROPERTIES
    @Environment(AvatarSheetVM.self) private var vm
    @State private var vm$: AvatarSheetVM = .shared
    
    // MARK: - PRIVATE PROPERTIES
    let extraGridHeight_1: CGFloat = 90
    let extraGridHeight_2: CGFloat = 45
    
    // MARK: - BODY
    var body: some View {
        TabView(selection: $vm$.selectedTabCollection) {
            ForEach(AvatarCollectionTypes.allCases, id: \.self) {
                AvatarSelectionVGridView(collectionName: $0)
            }
            .padding(.horizontal, 20)
            .geometryReaderDimensionViewModifier($vm$.lazyVGridHeight, dimension: .height)
            .frame(maxHeight: vm.lazyVGridHeight)
        }
        .frame(height: vm.lazyVGridHeight + extraGridHeight_1)
        .frame(height: vm.lazyVGridHeight + extraGridHeight_2, alignment: .bottom)
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
}

// MARK: - PREVIEWS
#Preview("AvatarSelectionTabContentView") {
    AvatarSelectionTabContentView()
        .previewViewModifier
}
