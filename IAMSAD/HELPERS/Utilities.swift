//
//  Utilities.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-19.
//

import SwiftUI
import AVFoundation

struct Utilities {
    // MARK: - getThumbnailFrom
    static func getThumbnailFrom(_ path: URL) -> UIImage? {
        do {
            let asset = AVURLAsset(url: path , options: nil)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imageGenerator.copyCGImage(at: .zero, actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            
            return thumbnail
        } catch {
            print("Error Generating Thumbnail For Video URL: \(path), \(error.localizedDescription) ❌❌❌")
            return nil
        }
    }
    
    // MARK: - extractYouTubeID
    static func extractYouTubeID(from url: String) -> String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/)|(?<=shorts/))([\\w-]+)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: url.utf16.count)
        
        guard let match = regex?.firstMatch(in: url, options: [], range: range) else {
            return nil
        }
        
        if let range = Range(match.range, in: url) {
            return String(url[range])
        }
        
        return nil
    }
}
