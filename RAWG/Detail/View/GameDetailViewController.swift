//
//  GameDetailViewController.swift
//  RAWG
//
//  Created by Azis on 04/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import UIKit

class GameDetailViewController: BaseViewController {
    
    @IBOutlet weak private var thumbnailView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var developersLabel: UILabel!
    @IBOutlet weak private var ratingLabel: UILabel!
    @IBOutlet weak private var releaseDateLabel: UILabel!
    @IBOutlet weak private var genresLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!

    private let viewModel = GameDetailViewModel()
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVM()
    }
    
    private func setupVM(){
        viewModel.onErrorResponse = {
            error in
            self.hideLoading()
            self.showAlert(message: error)
        }
        viewModel.onSuccessResponse = {
            self.hideLoading()
            self.updateUI()
        }
        showLoading()
        viewModel.fetchData(id: id)
    }
    
    private func updateUI(){
        if let data = viewModel.game {
            thumbnailView.sd_setImage(with: URL(string: data.backgroundImage), completed: nil)
            titleLabel.text = data.name
            releaseDateLabel.text = data.released.toString(format: "MMM d, yyyy")
            ratingLabel.text = "\(data.rating) | \(Helper.formatNumber(data.ratingsCount)) Ratings"
            var genres = ""
            for (index, genre) in data.genres.enumerated() {
                if index == 0 {
                    genres += genre.name
                } else {
                    genres += ", " + genre.name
                }
            }
            genresLabel.text = genres
            descriptionLabel.text = data.descriptionRaw
            var developers = ""
            for (index, developer) in data.developers.enumerated() {
                if index == 0 {
                    developers += developer.name
                } else {
                    developers += ", " + developer.name
                }
            }
        }
    }

}
