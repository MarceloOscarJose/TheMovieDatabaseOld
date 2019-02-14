//
//  MovieDetailView.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 2/12/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import AlamofireImage

protocol MovieDetailViewDelegate {
    func dismissDetailScreen()
}

class MovieDetailView: UIView {

    lazy var movieImage: UIImageView = {
        let movieImage = UIImageView()
        movieImage.contentMode = .scaleAspectFill
        movieImage.backgroundColor = UIColor.imageColor
        return movieImage
    }()
    var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.setTitle("Cerrar", for: .normal)
        closeButton.backgroundColor = UIColor.primaryColor
        return closeButton
    }()
    var videoButton: UIButton = {
        let videoButton = UIButton()
        videoButton.setTitle("Ver trailler", for: .normal)
        videoButton.backgroundColor = UIColor.secondaryColor
        return videoButton
    }()

    var imageHeight: CGFloat = 0
    var delegate: MovieDetailViewDelegate!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func setMovieData(delegate: MovieDetailViewDelegate, image: String?) {
        self.delegate = delegate
        setupControls(image: image)
        setupConstraints()
    }

    private func setupControls(image: String?) {
        self.backgroundColor = UIColor.white

        self.addSubview(movieImage)
        self.addSubview(closeButton)
        self.addSubview(videoButton)
        closeButton.addTarget(self, action: #selector(dismissDetailScreen), for: .touchUpInside)

        let placeholderImage = UIImage(named: "ImagePlaceholder")!

        if let imageURL = image {
            let url = URL(string: imageURL)!
            movieImage.af_setImage(withURL: url, placeholderImage: placeholderImage, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false) { (imageData) in
                self.imageHeight = self.movieImage.getImageHeight(width: self.frame.width / 2)
            }
        } else {
            let noImage = UIImage(named: "NoImage")!
            movieImage.image = noImage
            self.imageHeight = self.movieImage.getImageHeight(width: self.frame.width / 2)
        }
    }

    func setupConstraints() {
        movieImage.autoPinEdge(.top, to: .top, of: self, withOffset: 0)
        movieImage.autoPinEdge(.left, to: .left, of: self, withOffset: 0)
        movieImage.autoSetDimension(.width, toSize: self.frame.width / 2)
        movieImage.autoSetDimension(.height, toSize: imageHeight)

        closeButton.autoPinEdge(.top, to: .top, of: self, withOffset: 10)
        closeButton.autoPinEdge(.left, to: .right, of: movieImage, withOffset: 10)
        closeButton.autoPinEdge(.right, to: .right, of: self, withOffset: -10)

        videoButton.autoPinEdge(.top, to: .bottom, of: closeButton, withOffset: 10)
        videoButton.autoPinEdge(.left, to: .right, of: movieImage, withOffset: 10)
        videoButton.autoPinEdge(.right, to: .right, of: self, withOffset: -10)
    }

    @objc func dismissDetailScreen() {
        if let delegate = self.delegate {
            delegate.dismissDetailScreen()
        }
    }
}
