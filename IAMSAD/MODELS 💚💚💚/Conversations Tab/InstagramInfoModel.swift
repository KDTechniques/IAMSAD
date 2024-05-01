//
//  InstagramInfoModel.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-04-21.
//

import SwiftUI

struct InstagramInfoModel: Codable {
    let data: InstagramData
    
    struct InstagramData: Codable {
        let profilePhotoURL: String
        let name: String
        let userName: String
        let followers: FollowersData
        let followings: FollowingsData
        
        enum CodingKeys: String, CodingKey {
            case profilePhotoURL = "profile_pic_url"
            case name = "full_name"
            case userName = "username"
            case followers = "edge_followed_by"
            case followings = "edge_follow"
        }
    }
    
    struct FollowersData: Codable {
        let followersCount: Int
        
        enum CodingKeys: String, CodingKey {
            case followersCount = "count"
        }
    }
    
    struct FollowingsData: Codable {
        let followingsCount: Int
        
        enum CodingKeys: String, CodingKey {
            case followingsCount = "count"
        }
    }
}
