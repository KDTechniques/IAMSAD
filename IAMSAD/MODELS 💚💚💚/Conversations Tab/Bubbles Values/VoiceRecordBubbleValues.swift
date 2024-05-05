//
//  VoiceRecordBubbleValues.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-05-03.
//

import SwiftUI

struct VoiceRecordBubbleValues {
    enum ActionTypes: CaseIterable { case play, pause, cancel, upload }
    enum PlaybackSpeedTypes: String, CaseIterable { case _1x = "1", _1_5x = "1.5", _2x = "2" }
    enum FileDatatypes: CaseIterable { case fileSize, duration }
    
    static let actionIconsFrameWidth: CGFloat = 15
    static let actionIconsHPadding: CGFloat = 16
    static let imageSize: CGFloat = 45
    static let widthPerSpectrumFrame: CGFloat = 2.5
    static let spectrumMaxHeight: CGFloat = 24
    static let spacingPerSpectrumFrame: CGFloat = 1.8
    
    static var spectrumSafeWidth: CGFloat {
        let safeValue: CGFloat = 50 // an eye accurate value
        
        return MessageBubbleValues.maxContentWidth -
        imageSize -
        (actionIconsHPadding*2) -
        actionIconsFrameWidth -
        safeValue
    }
    
    static var framesCount: Int {
        let value1: Int = .init(spectrumSafeWidth)
        let value2: Int = .init(widthPerSpectrumFrame + spacingPerSpectrumFrame)
        
        return value1 / value2
    }
    
    static var actualSpectrumWidth: CGFloat {
        let value1: CGFloat = CGFloat(framesCount) * widthPerSpectrumFrame
        let value2: CGFloat = CGFloat(framesCount-1) * spacingPerSpectrumFrame
        
        return value1 + value2
    }
    
    static var strokedMicImageWidth: CGFloat {
        let image: UIImage = .init(named: "micStroked") ?? UIImage()
        let imageWidth: CGFloat = image.size.width
        
        return imageWidth
    }
    
    // MARK: - FUNCTIONS
    
    static func getMockArrayOfHeights() -> [CGFloat] {
        var randomHeight: CGFloat { CGFloat.random(in: 1...spectrumMaxHeight) }
        let heightsArray: [CGFloat] = (1...framesCount).map { _ in randomHeight }
        
        return heightsArray
    }
}
