//
//  Game.swift
//  RAWG
//
//  Created by Azis on 03/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import Foundation

struct Game: Codable {
    let name: String
    let released: Date
    let rating: Float
    var genres: [Genre] = []
    var ratingsCount: Int
    var backgroundImage: String
    
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
        ratingsCount = try container.decode(Int.self, forKey: .ratingsCount)
        backgroundImage = try container.decode(String.self, forKey: .backgroundImage)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case released
        case rating
        case genres
        case ratingsCount = "ratings_count"
        case backgroundImage = "background_image"
    }
}
