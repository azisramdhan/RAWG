//
//  Response.swift
//  RAWG
//
//  Created by Azis on 04/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import Foundation

struct Response: Codable {
    let count: Int
    let next: String
    let previous: Int?
    var results: [Game] = []
}
 
