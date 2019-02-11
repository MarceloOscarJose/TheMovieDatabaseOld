//
//  MainViewController.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 2/8/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit
import PXStickyHeaderCollectionView

class MainViewController: UIViewController {

    // Collection view ids
    let KCellId = "collectionCell"
    let KCellClass = "CollectionViewCell"

    // UI Vars
    var containerView: PXStickyHeaderCollectionView!

    // Data vars
    var moviesData: [MovieData] = []

    /*let containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()*/

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false

        getMovies()
    }

    func setupControls() {
        containerView = PXStickyHeaderCollectionView(initHeaderHeight: 200, minHeaderHeight: 50, headerView: UIView())
        self.view.addSubview(containerView)

        let margins = view.layoutMarginsGuide
        containerView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0).isActive = true

        containerView.collectionView.register(UINib(nibName: KCellClass, bundle: Bundle(for: MainViewController.self)), forCellWithReuseIdentifier: KCellId)
        containerView.delegate = self
        containerView.dataSource = self
    }

    func setupConstraints() {
        
    }

    func getMovies() {
        let movieModel = MovieModel()
        movieModel.getUpcommingMovies(responseHandler: { (movies) in
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
        cell.updateCellData(title: movieData.title, releaseDate: movieData.releaseDate, overview: movieData.overview)

        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = CGFloat(32.0)
        let availableWidth = view.frame.width - paddingSpace

        let widthPerItem = availableWidth / 4
        return CGSize(width: widthPerItem, height: 100)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 15, right: 8)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
