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
}

