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

    override func viewDidLoad() {
        super.viewDidLoad()
        profileVM.loadProfile()
        setupUI()
    }
    
    private func setupUI(){
        nameTextField.text = profileVM.profile.name
        addressTextField.text = profileVM.profile.address
        roleTextField.text = profileVM.profile.role
        aboutTextField.text = profileVM.profile.about
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAlert(title: "Edit Info", message: "Click on the text to edit")
    }
    
    private func setProfile(){
        profileVM.profile.name = nameTextField.text ?? ""
        profileVM.profile.address = addressTextField.text ?? ""
        profileVM.profile.role = roleTextField.text ?? ""
        profileVM.profile.about = aboutTextField.text ?? ""
    }

    @IBAction func roleTitleClicked(_ sender: UIButton) {
        showAlert(message: "Can't edit this text")
    }
    
    @IBAction func doneClicked(_ sender: UIBarButtonItem) {
        setProfile()
        profileVM.saveProfile()
        navigationController?.popViewController(animated: true)
    }
}
