//
//  GameTableViewCell.swift
//  RAWG
//
//  Created by Azis on 04/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import UIKit
import SDWebImage
import Cosmos

class GameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel! // 4.61 | 4K Ratings
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupWith(data: Game){
        if let thumbnail = data.backgroundImage {
            thumbnailView.sd_setImage(with: URL(string: thumbnail), completed: nil)
        }
        titleLabel.text = data.name
        releaseDateLabel.text = data.released?.toString(format: "MMM d, yyyy")
        ratingLabel.text = "\(data.rating ?? 0) | \(Helper.formatNumber(data.ratingsCount ?? 0)) Ratings"
        var genres = ""
        for (index, genre) in data.genres.enumerated() {
            if index == 0 {
                genres += genre.name ?? ""
            } else {
                genres += ", " + (genre.name ?? "")
            }
        }
        genresLabel.text = genres
        ratingView.settings.fillMode = .precise
        ratingView.rating = Double(data.rating ?? 0)
    }

}
