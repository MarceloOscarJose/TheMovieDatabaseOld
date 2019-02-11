//
//  MovieCollectionViewCell.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 2/11/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageContainer: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateCellData(image: String, title: String, releaseDate: String, overview: String) {
        titleLabel.text = title
        releaseDateLabel.text = releaseDate
        overviewLabel.text = overview != "" ? overview : "Sin descripción".localized

        let url = URL(string: image)!
        let placeholderImage = UIImage(named: "ImagePlaceholder")!

        imageContainer.af_setImage(
            withURL: url,
            placeholderImage: placeholderImage,
            imageTransition: .crossDissolve(0.2)
        )
    }
}
