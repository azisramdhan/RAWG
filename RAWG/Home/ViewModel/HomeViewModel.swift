//
//  HomeViewModel.swift
//  RAWG
//
//  Created by Azis on 03/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    var onSuccessResponse: (()->())?
    var onErrorResponse: ((String)->())?
    
    private var page = 1
    private var components = URLComponents(string: "https://api.rawg.io/api/games")!
    var games: [Game] = []
    
    func fetchData(search: String = "") {
        components.queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "search", value: String(search))
        ]
        let request = URLRequest(url: components.url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            DispatchQueue.main.async {
                if response.statusCode == 200 {
                    if let data = data {
                        let decoder = JSONDecoder()
                        do {
                            let response = try decoder.decode(Response.self, from: data)
                            self.games = response.results
                            self.onSuccessResponse?()
                        } catch let error {
                            self.onErrorResponse?("Not a Valid JSON Response with Error : \(error)")
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
