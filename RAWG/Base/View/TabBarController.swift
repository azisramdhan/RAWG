//
//  TabBarController.swift
//  RAWG
//
//  Created by Azis on 22/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc private func editTapped(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Edit") else { return }
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension TabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if let position = tabBar.items?.firstIndex(of: item), position == 2 {
            let edit = UIBarButtonItem(image: #imageLiteral(resourceName: "Edit"), style: .plain, target: self, action: #selector(editTapped))
            navigationItem.rightBarButtonItem = edit
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
}
