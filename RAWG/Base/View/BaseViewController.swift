//
//  BaseViewController.swift
//  RAWG
//
//  Created by Azis on 04/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var progress = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        progress.center = self.view.center
        progress.hidesWhenStopped = true
        view.addSubview(progress)
    }
    
    
    func showAlert(title: String = "Something Wrong", message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLoading() {
        progress.startAnimating()
    }
    
    func hideLoading(){
        progress.stopAnimating()
    }


}
