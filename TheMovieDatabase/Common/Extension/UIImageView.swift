//
//  UIImageView.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 2/11/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import AlamofireImage

extension UIImageView {

    public func imageFromServerURL(urlString: String) {
        let url = URL(string: urlString)
        self.af_setImage(withURL: url!, imageTransition: .crossDissolve(0.3))
    }
}
