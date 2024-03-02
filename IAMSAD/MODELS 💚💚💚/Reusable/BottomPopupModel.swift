//
//  BottomPopupModel.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-08.
//

import SwiftUI

// MARK: - ENUMS

// MARK: - BottomPopupTypes
enum BottomPopupTypes {
    case sound
    case scene
    case system
}

// MARK: - BottomPopupUsageTypes
enum BottomPopupUsageTypes {
    // Download Task Related
    case alreadyDownloaded
    case downloadInProgress
    case downloadingPaused
    case notDownloading
    case resumedAllDownloads
    case cancelAllPossibleDownloads
    case pauseAllPossibleDownloads
    
    // Scene Modification Related
    case successSceneCreation
    case successSceneCustomization
}

struct BottomPopupModel: Identifiable {
    // MARK: - PROPERTIES
    let id: String = UUID().uuidString
    let imagePathURL: URL?
    let systemImage: String?
    let type: BottomPopupTypes
    let text: String
    let usage: BottomPopupUsageTypes?
    let iconColor: Color?
    
    // MARK: - INITIALIZER
    init(
        imagePathURL: URL? = nil,
        systemImage: String? = nil,
        type: BottomPopupTypes,
        text: String,
        usage: BottomPopupUsageTypes? = nil,
        iconColor: Color? = nil
    ) {
        self.imagePathURL = imagePathURL
        self.systemImage = systemImage
        self.type = type
        self.text = text
        self.usage = usage
        self.iconColor = iconColor
    }
}
