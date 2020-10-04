//
//  HomeViewModel.swift
//  RAWG
//
//  Created by Azis on 03/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    private var page = 1
    private var components = URLComponents(string: "https://api.rawg.io/api/games")!
    var games: [Game] = []
    
    var onSuccessResponse: (()->())?
    var onErrorResponse: ((String)->())?
    
    func fetchData() {
        components.queryItems = [
            URLQueryItem(name: "page", value: String(page))
        ]
        let request = URLRequest(url: components.url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            DispatchQueue.main.async {
                if let data = data {
                    if response.statusCode == 200 {
                        let decoder = JSONDecoder()
                        if let response = try? decoder.decode(Response.self, from: data) {
                            self.games = response.results
                            self.onSuccessResponse?()
                        } else {
                            self.onErrorResponse?("Not a Valid JSON Response")
                        }
                    } else {
                        self.onErrorResponse?("HTTP Status: \(response.statusCode)")
                    }
                }
            }
        }
        task.resume()
    }
}
