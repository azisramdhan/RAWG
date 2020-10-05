//
//  Developer.swift
//  RAWG
//
//  Created by Azis on 04/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import Foundation

struct Developer: Codable {
    let id: Int?
    let name: String?
    let slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}
