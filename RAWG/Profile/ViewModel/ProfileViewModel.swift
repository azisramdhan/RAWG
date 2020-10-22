//
//  ProfileViewModel.swift
//  RAWG
//
//  Created by Azis on 20/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import Foundation

class ProfileViewModel {
    
    private let PROFILE: String = "Profile"
    var profile: Profile = Profile()
    
    func loadProfile() {
        let userDefaults = UserDefaults.standard
        do {
            profile = try userDefaults.getObject(forKey: PROFILE, castTo: Profile.self)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveProfile() {
        let userDefaults = UserDefaults.standard
        do {
            try userDefaults.setObject(profile, forKey: PROFILE)
        } catch {
            print(error.localizedDescription)
        }
    }
}
