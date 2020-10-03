//
//  Genre.swift
//  RAWG
//
//  Created by Azis on 03/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import Foundation

struct Genre: Codable {
    let id: Int
    let name: String
    let slug: String
    let games_count: Int
    let image_background: String
}
