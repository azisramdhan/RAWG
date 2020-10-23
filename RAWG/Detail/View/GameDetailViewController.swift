//
//  GameDetailViewController.swift
//  RAWG
//
//  Created by Azis on 04/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import UIKit
import Cosmos
import AVKit

class GameDetailViewController: BaseViewController {
    
    @IBOutlet weak private var thumbnailView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var developersLabel: UILabel!
    @IBOutlet weak private var ratingLabel: UILabel!
    @IBOutlet weak private var releaseDateLabel: UILabel!
    @IBOutlet weak private var genresLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var ratingView: CosmosView!
    @IBOutlet weak private var previewClipView: UIImageView!
    @IBOutlet weak private var favoriteSwitch: UISwitch!
    
    private let viewModel = GameDetailViewModel()
    var id: Int = -1
    var genres = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupVM()
        setupProvider()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    private func setupUI(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
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
    
    private func setupProvider(){
        favoriteProvider.get(id, completion: { game in
            DispatchQueue.main.async {
                self.favoriteSwitch.setOn(true, animated: false)
            }
        })
    }
    
    private func updateUI(){
        if let data = viewModel.game {
            if let preview = data.clip?.preview {
                previewClipView.sd_setImage(with: URL(string: preview), completed: nil)
            }
            if let thumbnail = data.backgroundImage {
                thumbnailView.sd_setImage(with: URL(string: thumbnail), completed: nil)
            }
            titleLabel.text = data.name
            releaseDateLabel.text = data.released?.toString(format: "MMM d, yyyy")
            ratingLabel.text = "\(data.rating ?? 0) | \(Helper.formatNumber(data.ratingsCount ?? 0)) Ratings"
            for (index, genre) in data.genres.enumerated() {
                if index == 0 {
                    genres += genre.name ?? ""
                } else {
                    genres += ", " + (genre.name ?? "")
                }
            }
            genresLabel.text = genres
            descriptionLabel.text = data.descriptionRaw
            var developers = ""
            for (index, developer) in data.developers.enumerated() {
                if index == 0 {
                    developers += developer.name ?? ""
                } else {
                    developers += ", " + (developer.name ?? "")
                }
            }
            developersLabel.text = developers
            ratingView.settings.fillMode = .precise
            ratingView.rating = Double(data.rating ?? 0)
        }
    }
    @IBAction func switchChanged(_ sender: UISwitch) {
        if let game = viewModel.game {
            if sender.isOn {
                favoriteProvider.create(Int32(id), genres, game.name ?? "", game.rating ?? 0, Int32(game.ratingsCount ?? 0), game.backgroundImage ?? "", game.released ?? Date()) {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Successful", message: "Added to favorites")
                    }
                }
            } else {
                favoriteProvider.delete(id, completion: {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Successful", message: "Deleted from favorites")
                    }
                })
            }
        }
    }
    
    @IBAction func previewClicked(_ sender: UIButton) {
        if let data = viewModel.game {
            if let clip = data.clip?.clip {
                let player = AVPlayer(url: URL(string: clip)!)
                let vc = AVPlayerViewController()
                vc.player = player

                present(vc, animated: true) {
                    vc.player?.play()
                }
            } else {
                showAlert(message: "Sorry, preview is not available")
            }
        }
    }
    
    @IBAction func closeClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
