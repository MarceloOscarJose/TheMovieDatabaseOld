//
//  MainViewController.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 2/8/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit
import PXStickyHeaderCollectionView
import PureLayout

class MainViewController: UIViewController {

    // Collection view ids
    let KCellId = "movieCollectionCell"
    let KCellClass = "MovieCollectionViewCell"

    // UI Vars
    let cellTopPadding: CGFloat = 20.0
    let cellBottomPadding: CGFloat = 15.0
    let minHeaderHeight: CGFloat = 70
    let initialHeaderHeight: CGFloat = 170

    var containerView: PXStickyHeaderCollectionView!

    // Data vars
    let movieModel = MovieModel()
    var moviesData: [MovieData] = []
    var nextPage: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupControls()
        getMovies()
    }

    func setupControls() {
        self.view.backgroundColor = UIColor.primaryColor
        containerView = PXStickyHeaderCollectionView(initHeaderHeight: initialHeaderHeight, minHeaderHeight: minHeaderHeight, headerView: MainHeaderView())
        self.view.addSubview(containerView)
        containerView.autoPinEdgesToSuperviewSafeArea()

        let cellNib = UINib(nibName: KCellClass, bundle: Bundle(for: MainViewController.self))
        containerView.collectionView.register(cellNib, forCellWithReuseIdentifier: KCellId)
        containerView.delegate = self
        containerView.dataSource = self
    }

    func getMovies() {
        movieModel.getUpcommingMovies(nextPage: self.nextPage, responseHandler: { (movies) in
            self.moviesData = movies
            self.containerView.collectionView.reloadData()
        }) { (error) in
            print(error!)
        }
    }

    func showMovieDetail(movieData: MovieData) {
        let movieDetailViewController = MovieDetailViewController(movieData: movieData)
        movieDetailViewController.modalPresentationStyle = .overCurrentContext
        movieDetailViewController.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(movieDetailViewController, animated: true, completion: nil)
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesData.count
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.showMovieDetail(movieData: self.moviesData[indexPath.item])
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCellId, for: indexPath) as! MovieCollectionViewCell

        let movieData = self.moviesData[indexPath.item]
        cell.updateCellData(image: movieData.poster, title: movieData.title, releaseDate: movieData.releaseDate, overview: movieData.overview)

        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = self.view.frame.width
        return CGSize(width: widthPerItem, height: 200)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellTopPadding, left: 0, bottom: self.cellBottomPadding, right: 0)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.moviesData.count - 1 {
            self.nextPage = true
            self.getMovies()
        }
    }
}
