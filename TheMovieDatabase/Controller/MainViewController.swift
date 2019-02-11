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
    let cellLeftRightPadding: CGFloat = 10.0
    let cellBottomPadding: CGFloat = 15.0
    let minHeaderHeight: CGFloat = 70
    let initialHeaderHeight: CGFloat = 170

    var containerView: PXStickyHeaderCollectionView!

    // Data vars
    var moviesData: [MovieData] = []

    /*let containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()*/

    override func viewDidLoad() {
        super.viewDidLoad()
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

    func setupConstraints() {
        
        /*NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true*/
    }

    func getMovies() {
        let movieModel = MovieModel()
        movieModel.getUpcommingMovies(responseHandler: { (movies) in
            self.moviesData = movies
            self.setupControls()
            self.setupConstraints()
        }) { (error) in
            print(error!)
        }
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
        print("Selected item")
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCellId, for: indexPath) as! MovieCollectionViewCell

        let movieData = self.moviesData[indexPath.item]
        cell.updateCellData(image: movieData.poster, title: movieData.title, releaseDate: movieData.releaseDate, overview: movieData.overview)

        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = self.view.frame.width - (self.cellLeftRightPadding * 2)
        return CGSize(width: widthPerItem, height: 200)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellTopPadding, left: self.cellLeftRightPadding, bottom: 15, right: self.cellLeftRightPadding)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
