//
//  Profile.swift
//  RAWG
//
//  Created by Azis on 20/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import Foundation

struct Profile: Codable {
    var image: Data?
    var name: String = "Your Name"
    var address: String = "Your Address"
    var role: String = "Your Job Title / Position"
    var about: String = "You can write a little about yourself here"
}
