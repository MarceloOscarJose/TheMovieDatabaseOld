//
//  MainHeaderView.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 2/11/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit
import PureLayout

class MainHeaderView: UIView {

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = UIColor.primaryColor
        searchBar.layer.borderColor = UIColor.primaryColor.cgColor
        return searchBar
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupControls()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupControls() {
        self.backgroundColor = UIColor.primaryColor
        self.addSubview(searchBar)
        
    }

    func setupConstraints() {
        searchBar.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -20)
        searchBar.autoPinEdge(.left, to: .left, of: self, withOffset: 0)
        searchBar.autoPinEdge(.right, to: .right, of: self, withOffset: 0)
    }
}
