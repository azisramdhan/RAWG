//
//  GameDetail.swift
//  RAWG
//
//  Created by Azis on 04/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import Foundation

struct GameDetail: Codable {
    let name: String
    let released: Date
    let rating: Float
    let genres: [Genre]
    let developers: [Developer]
    let clip: Clip
    let ratingsCount: Int
    let descriptionRaw: String
    let backgroundImage: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        let dateString = try container.decode(String.self, forKey: .released)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)!
        released = date
        rating = try container.decode(Float.self, forKey: .rating)
        genres = try container.decode([Genre].self, forKey: .genres)
        developers = try container.decode([Developer].self, forKey: .developers)
        clip = try container.decode(Clip.self, forKey: .clip)
        ratingsCount = try container.decode(Int.self, forKey: .ratingsCount)
        descriptionRaw = try container.decode(String.self, forKey: .descriptionRaw)
        backgroundImage = try container.decode(String.self, forKey: .backgroundImage)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case rating
        case released
        case genres
        case developers
        case clip
        case ratingsCount = "ratings_count"
        case descriptionRaw = "description_raw"
        case backgroundImage = "background_image"
    }
}
