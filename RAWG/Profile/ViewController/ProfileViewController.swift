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
    private let profileVM = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileVM.loadProfile()
        setupUI()
    }
    
    private func setupUI(){
        nameLabel.text = profileVM.profile.name
        addressLabel.text = profileVM.profile.address
        roleLabel.text = profileVM.profile.role
        aboutLabel.text = profileVM.profile.about
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! EditProfileViewController
        vc.profile = profileVM.profile
    }

}
