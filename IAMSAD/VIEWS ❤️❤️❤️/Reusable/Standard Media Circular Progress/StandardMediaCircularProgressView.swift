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
    let rotateProgress: Bool
    let withBackground: Bool
    let action: () -> Void
    
    // MARK: - INITIALIZER
    init(
        value: CGFloat,
        showProgress: Bool,
        rotateProgress: Bool = false,
        withBackground: Bool = true,
        action: @escaping () -> Void
    ) {
        self.value = value
        self.showProgress = showProgress
        self.rotateProgress = rotateProgress
        self.withBackground = withBackground
        self.action = action
    }
    
    // MARK: - PRIVATE PROPERTIES
    let progressValues = StandardMediaCircularProgressValues.self
    var circleSize: CGFloat { progressValues.frameSize }
    var progressFrameSize: CGFloat { circleSize - 6 }
    var animation: Animation { progressValues.expandableAnimation }
    
    // MARK: - BODY
    var body: some View {
        Color.clear
            .frame(width: circleSize, height: circleSize)
            .standardCircularProgressBackgroundViewModifier(colorScheme, withBackground)
            .clipShape(Circle())
            .overlay {
                if showProgress {
                    circularProgress
                } else {
                    StandardMediaCircularProgress_ArrowDownView()
                }
            }
            .transition(.scale)
            .animation(animation, value: showProgress)
            .onTapGesture { action() }
    }
}

// MARK: - PREVIEWS
#Preview("StandardMediaCircularProgressView") {
    StandardMediaCircularProgressView(
        value: 0.75,
        showProgress: .random(),
        rotateProgress: .random()
    ) {
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
            rotateProgress: rotateProgress,
            stopRectangleColor: .arrowDown,
            stopRectanglePadding: 19,
            cornerRadius: 2
        )
    }
}

// MARK: - OTHER
struct StandardMediaCircularProgressValues {
    static let frameSize: CGFloat = 54
    static let expandableAnimation: Animation = .smooth(duration: 0.25)
    static let rotatableAnimation: Animation = .easeInOut(duration: 1.25).repeatForever(autoreverses: false)
}
