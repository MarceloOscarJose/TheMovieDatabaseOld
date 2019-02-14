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

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageContainer: UIImageView!
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageContainer.backgroundColor = UIColor.imageColor
        addShadow()
    }

    func addShadow() {
        containerView.backgroundColor = UIColor.white
        containerView.layer.shadowColor = UIColor.shadowColor.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize(width: 10, height: 3)
        containerView.layer.shadowRadius = 5
    }

    func updateCellData(image: String?, title: String, releaseDate: String, overview: String) {

        titleLabel.text = title
        releaseDateLabel.text = releaseDate
        overviewLabel.text = overview != "" ? overview : "Sin descripción".localized

        let placeholderImage = UIImage(named: "ImagePlaceholder")!

        if let img = image {
            let url = URL(string: img)!
            imageContainer.af_setImage(withURL: url, placeholderImage: placeholderImage, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true) { (imageData) in
                self.imageWidthConstraint.constant = self.imageContainer.getImageWidth(height: self.frame.height)
            }
        } else {
            imageContainer.image = UIImage(named: "NoImage")!
            imageWidthConstraint.constant = imageContainer.getImageWidth(height: self.frame.height)
        }
    }
}
