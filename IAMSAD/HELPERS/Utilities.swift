//
//  Utilities.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-19.
//

import SwiftUI
import AVFoundation
import SDWebImageSwiftUI

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
    
    // MARK: - getSocialMediaType
    static func getSocialMediaType(by url: String) -> SocialMediaTypes? {
        if url.contains("facebook.com") {
            return .facebook
        } else if url.contains("instagram.com") {
            return .instagram
        } else if url.contains("youtube.com") {
            return .youtube
        } else if url.contains("tiktok.com") {
            return .tiktok
        } else {
            return nil
        }
    }
    
    // MARK: - getSocialMediaID
    static func getSocialMediaID(from url: String, type: SocialMediaTypes) -> String? {
        var pattern: String {
            switch type {
            case .facebook:
                "(?<=facebook\\.com/)[^/?#&]+"
            case .instagram:
                "(?<=instagram\\.com/)[^/?#&]+"
            case .youtube:
                "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/)|(?<=shorts/))([\\w-]+)"
            case .tiktok:
                "(?<=https://vt\\.tiktok\\.com/)([\\w-]+)"
            }
        }
        
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
    
    // MARK: - getTikTokInfoData
    static func getTikTokInfoData(id: String) async -> TikTokInfoModel? {
        let headers: [String: String] = [
            "X-RapidAPI-Key": "1c876fdb4emshe21e1c515423661p1111b9jsn52ad6f81f06e",
            "X-RapidAPI-Host": "tiktok-scraper7.p.rapidapi.com"
        ]
        
        guard let url: URL = .init(string: "https://tiktok-scraper7.p.rapidapi.com/?url=https%3A%2F%2Fvt.tiktok.com%2F\(id)%2F&hd=1") else { return nil }
        
        var request: URLRequest = .init(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let decoder: JSONDecoder = .init()
        
        guard let (data, _) = try? await URLSession.shared.data(for: request),
              let model: TikTokInfoModel = try? decoder.decode(TikTokInfoModel.self, from: data) else { return nil }
        
        return model
    }
    
    // MARK: - getInstagramInfoData
    static func getInstagramInfoData(id: String) async -> InstagramInfoModel? {
        let headers: [String: String] = [
            "X-RapidAPI-Key": "1c876fdb4emshe21e1c515423661p1111b9jsn52ad6f81f06e",
            "X-RapidAPI-Host": "instagram243.p.rapidapi.com"
        ]
        
        guard let url: URL = .init(string: "https://instagram243.p.rapidapi.com/userinfo/\(id)") else { return nil }
        
        var request: URLRequest = .init(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let decoder: JSONDecoder = .init()
        
        guard let (data, _) = try? await URLSession.shared.data(for: request),
              let model: InstagramInfoModel = try? decoder.decode(InstagramInfoModel.self, from: data) else { return nil }
        
        return model
    }
    
    // MARK: - getFacebookInfoData
    static func getFacebookInfoData(id: String) async -> FacebookInfoModel? {
        nil
    }
    
    // MARK: - getYoutubeInfoData
    static func getYoutubeInfoData(id: String) async -> YoutubeInfoModel? {
        nil
    }
    
    // MARK: - separateTextAndURLs
    static private func separateTextAndURLs(from text: String) -> [(content: String, isURL: Bool)] {
        var result: [(content: String, isURL: Bool)] = []
        
        // Attempt to create a data detector for links
        guard let urlDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return [] }
        
        // Find all matches in the input string
        let matches = urlDetector.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
        
        // Keep track of the last range end to find non-URL strings
        var lastRangeEnd = text.startIndex
        
        // Iterate through all matches
        for match in matches {
            guard let range = Range(match.range, in: text) else { continue }
            
            // Add the non-URL string before the current URL
            let nonURLString = String(text[lastRangeEnd..<range.lowerBound])
            if !nonURLString.isEmpty {
                result.append((content: nonURLString, isURL: false))
            }
            
            // Add the current URL
            let urlString = String(text[range])
            result.append((content: urlString, isURL: true))
            
            // Update the last range end
            lastRangeEnd = range.upperBound
        }
        
        // Add any remaining non-URL string after the last URL
        let remainingString = String(text[lastRangeEnd...])
        if !remainingString.isEmpty {
            result.append((content: remainingString, isURL: false))
        }
        
        return result
    }
    
    // MARK: - getUnderlinedHyperlinkText
    static func getUnderlinedHyperlinkText(_ text: String) -> Text {
        let results: [(content: String, isURL: Bool)] = separateTextAndURLs(from: text)
        
        var modifiedText: Text = results.isEmpty ? .init(text) : .init("")
        
        for result in results {
            modifiedText = modifiedText +
            Text(LocalizedStringKey(result.content))
                .underline(result.isURL, color: .accent)
                .foregroundStyle(result.isURL ? .accent : .primary)
        }
        
        return modifiedText
    }
    
    // MARK: - isCached
    static func isCached(_ url: URL?) -> Bool {
        let key: String? = SDWebImageManager.shared.cacheKey(for: url)
        return SDImageCache.shared.diskImageDataExists(withKey: key)
    }
    
    // MARK: - formatFileSize
    static func formatFileSize(_ fileSizeBytes: UInt64) -> String {
        let units: [String] = ["Bytes", "KB", "MB", "GB"]
        let base: Double = 1024.0
        var fileSize = Double(fileSizeBytes)
        var unitIndex = 0
        
        while fileSize >= base, unitIndex < units.count - 1 {
            fileSize /= base
            unitIndex += 1
        }
        
        let formattedSize = String(format: "%.0f %@", fileSize, units[unitIndex])
        
        return formattedSize
    }
}
