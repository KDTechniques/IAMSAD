//
//  StandardMediaCircularProgressView.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-15.
//

import SwiftUI

struct StandardMediaCircularProgressView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    let value: CGFloat
    let showProgress: Bool
    let action: () -> Void
    
    // MARK: - INITIALIZER
    init(value: CGFloat, showProgress: Bool, action: @escaping () -> Void) {
        self.value = value
        self.showProgress = showProgress
        self.action = action
    }
    
    // MARK: - PRIVATE PROPERTIES
    let circleSize: CGFloat = StandardMediaCircularProgressValues.frameSize
    var progressFrameSize: CGFloat { circleSize - 6}
    
    // MARK: - BODY
    var body: some View {
        Color.clear
            .frame(width: circleSize, height: circleSize)
            .standardCircularProgressBackgroundViewModifier(colorScheme)
            .clipShape(Circle())
            .overlay {
                if showProgress {
                    circularProgress
                } else {
                    StandardMediaCircularProgress_ArrowDownView()
                }
            }
            .onTapGesture { action() }
    }
}

// MARK: - PREVIEWS
#Preview("StandardMediaCircularProgressView") {
    StandardMediaCircularProgressView(value: .random(in: 0.2...0.75), showProgress: .random()) {
        print("Action triggered!")
    }
}

// MARK: - EXTENSIONS
extension StandardMediaCircularProgressView {
    // MARK: - circularProgress
    private var circularProgress: some View {
        CustomCircularProgressBarView(
            value: value,
            circleStrokeColor: .clear,
            progressStrokeColor: .arrowDown,
            strokeWidth: 2,
            circleSize: progressFrameSize,
            stopRectangleColor: .arrowDown,
            stopRectanglePadding: 19,
            cornerRadius: 2
        )
    }
}

// MARK: - OTHER
struct StandardMediaCircularProgressValues {
    static let frameSize: CGFloat = 54
}
