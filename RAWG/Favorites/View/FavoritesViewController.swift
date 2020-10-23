//
//  FavoritesViewController.swift
//  RAWG
//
//  Created by Azis on 23/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import UIKit

class FavoritesViewController: BaseViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var emptyView: UIView!
    private var favorites: [FavoriteModel] = []
    private var id: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        favoriteProvider.getAll(completion: {
            favorites in
            DispatchQueue.main.async {
                self.favorites = favorites
                self.emptyView.isHidden = !favorites.isEmpty
                self.tableView.reloadData()
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameDetail" {
            if let viewController = segue.destination as? GameDetailViewController {
               viewController.id = id
            }
        }
    }

}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameTableViewCell
        cell.setupWith(data: favorites[indexPath.row])
        return cell
    }
    
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        id = Int(favorites[indexPath.row].id!)
        performSegue(withIdentifier: "GameDetail", sender: nil)
    }
}
