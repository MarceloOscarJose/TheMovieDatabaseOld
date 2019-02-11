//
//  MainViewController.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 2/8/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit
import PureLayout

class MainViewController: UIViewController {

    let containerView: UIView = {
        let containerView = UIView.newAutoLayout()
        return containerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false

        // Setup UI
        setupControls()
        setupConstraints()

        getMovies()
    }

    func setupControls() {
        
    }

    func setupConstraints() {
        
    }

    func getMovies() {
        let movieModel = MovieModel()
        movieModel.getUpcommingMovies(responseHandler: { (movies) in
            print(movies)
        }) { (error) in
            print(error!)
        }
    }
}

/*extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellModel.count
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected item")
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCellId, for: indexPath) as! CollectionViewCell
        cell.configureCell(image: UIImage(named: cellModel[indexPath.item].image), title: cellModel[indexPath.item].title)
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
}*/
