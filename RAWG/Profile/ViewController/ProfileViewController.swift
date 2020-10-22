//
//  ProfileViewController.swift
//  RAWG
//
//  Created by Azis on 20/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var addressLabel: UILabel!
    @IBOutlet weak private var roleLabel: UILabel!
    @IBOutlet weak private var aboutLabel: UILabel!
    @IBOutlet weak private var imageView: UIImageView!
    private let profileVM = ProfileViewModel()
    var imagePicker: ImagePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        showAlert(title: "Image Profile", message: "Click on the image to change")
        setupPicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileVM.loadProfile()
        setupUI()
    }
    
    private func setupPicker(){
        imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    private func setupUI(){
        if let imageData = profileVM.profile.image {
            imageView.image = UIImage(data: imageData)
        }
        nameLabel.text = profileVM.profile.name
        addressLabel.text = profileVM.profile.address
        roleLabel.text = profileVM.profile.role
        aboutLabel.text = profileVM.profile.about
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! EditProfileViewController
        vc.profile = profileVM.profile
    }

    @IBAction func imageClicked(_ sender: UIButton) {
        imagePicker.present(from: sender)
    }
}

extension ProfileViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        if let image = image {
            imageView.image = image
            profileVM.profile.image = image.pngData()
            profileVM.saveProfile()
        }
    }
}
