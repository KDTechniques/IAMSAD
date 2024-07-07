//
//  AvatarSelectionHeaderTitleView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-07-06.
//

import SwiftUI

struct AvatarSelectionHeaderTitleView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    @Environment(AvatarSheetVM.self) private var vm
    
    private var sectionHeaderColor: Color {
        colorScheme == .dark ? Color(uiColor: .lightGray) : Color(uiColor: .darkGray)
    }
    
    // MARK: - BODY
    var body: some View {
        Text(vm.selectedTabCollection.rawValue)
            .fontWeight(.semibold)
            .foregroundStyle(sectionHeaderColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
    }
}

// MARK: - PREVIEWS
#Preview("AvatarSelectionHeaderTitleView") {
    AvatarSelectionHeaderTitleView()
        .previewViewModifier
}
