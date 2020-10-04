//
//  ViewController.swift
//  RAWG
//
//  Created by Azis on 03/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak private var textField: UITextField!
    @IBOutlet weak private var tableView: UITableView!
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupVM()
    }

    private func setupUI(){
        textField.attributedPlaceholder = NSAttributedString(string: "Search game", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5411764706, green: 0.5411764706, blue: 0.5411764706, alpha: 1)])
    }
    
    private func setupVM(){
        viewModel.onErrorResponse = { error in
            self.showAlert(message: error)
        }
        
        viewModel.onSuccessResponse = {
            self.tableView.reloadData()
        }
        
        viewModel.fetchData()
    }

    @IBAction func searchClicked(_ sender: UIButton) {
        
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameTableViewCell
        cell.setupWith(data: viewModel.games[indexPath.row])
        return cell
    }
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GameDetail", sender: nil)
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
