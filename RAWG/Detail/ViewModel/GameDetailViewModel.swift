//
//  GamaDetailViewModel.swift
//  RAWG
//
//  Created by Azis on 04/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import Foundation

class GameDetailViewModel {

    var onSuccessResponse: (()->())?
    var onErrorResponse: ((String)->())?
    
    var game: GameDetail?
      
    func fetchData(id: String = "") {
        let url = URL(string: "https://api.rawg.io/api/games/\(id)")
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let response = response as? HTTPURLResponse else { return }
          DispatchQueue.main.async {
              if let data = data {
                  if response.statusCode == 200 {
                      let decoder = JSONDecoder()
                      if let response = try? decoder.decode(GameDetail.self, from: data) {
                          self.game = response
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
