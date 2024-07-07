//
//  SeeAllAvatarSheetContentView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-25.
//

import SwiftUI

struct SeeAllAvatarSheetContentView: View {
    // MARK: - PROPERTIES
    @State private var selectedCollection: AvatarCollectionModel? = nil
    @State private var showRowBackground: Bool = false
    
    // MARK: BODY
    var body: some View {
        VStack {
            SeeAllAvatarSheetTitleView()
            
            SeeAllAvatarSheetScrollView(
                selectedCollection: $selectedCollection,
                showRowBackground: $showRowBackground
            )
        }
        .padding(.top, 50)
        .presentationDragIndicator(.visible)
        .sheet(item: $selectedCollection) {
            AvatarCollectionSheetView(
                showRowBackground: $showRowBackground,
                item: $0
            )
        }
    }
}

// MARK: - PREVIEWS
#Preview("SeeAllAvatarSheetContentView") {
    Color.clear
        .sheet(isPresented: .constant(true)) { SeeAllAvatarSheetContentView() }
        .previewViewModifier
}
