//
//  VoiceRecordBubbleValues.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-03.
//

import SwiftUI

struct VoiceRecordBubbleValues {
    enum ActionTypes { case play, pause, cancel }
    enum PlaybackSpeedTypes: CaseIterable { case _1x, _1_5x, _2x  }
    enum FileDatatypes { case fileSize, duration }
    
    static let playPauseIconsWidth: CGFloat = 15
    static let imageSize: CGFloat = 45
    static let widthPerSpectrumFrame: CGFloat = 2.5
    static let spectrumMaxHeight: CGFloat = 24
    static let spacingPerSpectrumFrame: CGFloat = 1.8
    static let spectrumMaxWidth: CGFloat = 150
    
    static var framesCount: Int {
        let value1: Int = .init(spectrumMaxWidth)
        let value2: Int = .init(widthPerSpectrumFrame + spacingPerSpectrumFrame)
        
        return value1 / value2
    }
    
    static func getMockArrayOfHeights() -> [CGFloat] {
        var randomHeight: CGFloat { CGFloat.random(in: 1...spectrumMaxHeight) }
        var heightsArray: [CGFloat] = (1...framesCount).map { _ in randomHeight }
        
        return heightsArray
    }
}
