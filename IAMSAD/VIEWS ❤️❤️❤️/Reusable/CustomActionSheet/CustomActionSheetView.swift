//
//  CustomActionSheetView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-07.
//

import SwiftUI

struct CustomActionSheetView<T: View>: View {
    // MARK: - PROPERTIES
    let content: T
    let dismissAction: () -> Void
    
    @State private var height: CGFloat = 0
    
    // MARK: - INITIALIZER
    init(@ViewBuilder content: () -> T, dismissAction: @escaping () -> Void) {
        self.content = content()
        self.dismissAction = dismissAction
        self.height = height
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 12) { content }
            .padding()
            .presentationDetents([.height(height)])
            .presentationCornerRadius(20)
            .presentationBackground(Color(uiColor: .systemGray6))
            .geometryReaderDimensionViewModifier($height, dimension: .height)
            .sheetTopTrailingCloseButtonViewModifier(size: 30) { dismissAction() }
    }
}

// MARK: - PREVIEWS
#Preview("CustomActionSheetView") {
    CustomActionSheetView {
        CustomActionSheetHeadlineView(text: "This is a sample headline.", accountType: .personal)
        
        CustomActionSheetSubHeadlineView("This is a sample sub headline.")
        
        CustomActionSheetButtonsView {[
            .init(text: "Sample Button 1", systemImageName: "star.fill") { print("star1") },
            .init(text: "Sample Button 2", systemImageName: "star.fill") { print("star2") },
            .init(text: "Sample Button 3", systemImageName: "star.fill") { print("star3") },
            .init(text: "Sample Button 4", systemImageName: "star.fill") { print("star4") }
        ]}
    } dismissAction: {
        print("Dissmissed!")
    }
}
