//
//  EditProfileViewController.swift
//  RAWG
//
//  Created by Azis on 21/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import UIKit

class EditProfileViewController: BaseViewController {
    
    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak private var addressTextField: UITextField!
    @IBOutlet weak private var roleTextField: UITextField!
    @IBOutlet weak private var aboutTextField: UITextView!
    
    private let profileVM = ProfileViewModel()
    var profile: Profile!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showInfo()
    }
    
    private func setupUI(){
        nameTextField.text = profile.name
        addressTextField.text = profile.address
        roleTextField.text = profile.role
        aboutTextField.text = profile.about
    }
    
    private func showInfo(){
        showAlert(title: "Edit Info", message: "Click on the text to edit")
    }
    
    private func setProfile(){
        profile.name = nameTextField.text ?? ""
        profile.address = addressTextField.text ?? ""
        profile.role = roleTextField.text ?? ""
        profile.about = aboutTextField.text ?? ""
    }

    @IBAction func roleTitleClicked(_ sender: UIButton) {
        showAlert(message: "Can't edit this text")
    }
    
    @IBAction func doneClicked(_ sender: UIBarButtonItem) {
        setProfile()
        profileVM.profile = profile
        profileVM.saveProfile()
        navigationController?.popViewController(animated: true)
    }
}
