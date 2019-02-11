//
//  MovieCollectionViewCell.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 2/11/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateCellData(title: String, releaseDate: String, overview: String) {
        titleLabel.text = title
        releaseDateLabel.text = releaseDate
        overviewLabel.text = overview
    }
}
