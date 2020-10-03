//
//  ViewController.swift
//  RAWG
//
//  Created by Azis on 03/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak private var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI(){
        textField.attributedPlaceholder = NSAttributedString(string: "Search game", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5411764706, green: 0.5411764706, blue: 0.5411764706, alpha: 1)])
    }

    @IBAction func searchClicked(_ sender: UIButton) {
        
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
        return cell
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    
}
