//
//  MovieDetailViewController.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 2/12/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit
import PureLayout

class MovieDetailViewController: UIViewController, MovieDetailViewDelegate {

    var movieData: MovieData!
    let detailView = MovieDetailView()

    convenience init(movieData: MovieData) {
        self.init()
        self.movieData = movieData
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        detailView.autoPinEdgesToSuperviewMargins(with: UIEdgeInsets(top: 30, left: 15, bottom: 30, right: 15))
        detailView.layoutIfNeeded()
        detailView.setMovieData(delegate: self, image: movieData.poster)
    }

    func setupControls() {
        self.view.backgroundColor = UIColor.shadowColor.withAlphaComponent(0.7)
        self.view.addSubview(detailView)
    }

    func dismissDetailScreen() {
        self.dismiss(animated: true, completion: nil)
    }
}
