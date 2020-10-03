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
    let released: String
    let rating: Float
    let genres: [Genre]
}
