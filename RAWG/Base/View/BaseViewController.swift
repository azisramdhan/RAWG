//
//  BaseViewController.swift
//  RAWG
//
//  Created by Azis on 04/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "Something Wrong", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
