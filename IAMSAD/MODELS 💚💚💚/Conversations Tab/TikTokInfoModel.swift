//
//  TikTokInfoModel.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-21.
//

import SwiftUI

struct TikTokInfoModel: Codable {
    let data: TikTokData
    
    struct TikTokData: Codable {
        let videoURL: String
        let coverPhotoURL: String?
        let author: TikTokAuthor
        let likesCount: Int
        let commentCount: Int
        let title: String
        
        enum CodingKeys: String, CodingKey {
            case videoURL = "play"
            case coverPhotoURL = "cover"
            case author
            case likesCount = "digg_count"
            case commentCount = "comment_count"
            case title
        }
    }
    
    struct TikTokAuthor: Codable {
        let nickname: String
    }
}
