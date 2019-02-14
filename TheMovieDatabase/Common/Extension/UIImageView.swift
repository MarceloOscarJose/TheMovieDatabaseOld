//
//  UIImageView.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 2/11/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import AlamofireImage

extension UIImageView {

    public func getImageHeight(width: CGFloat) -> CGFloat {
        var height: CGFloat = 0.0
        if let image = self.image {
            height = width * image.size.height / image.size.width
        }

        return height
    }

    public func getImageWidth(height: CGFloat) -> CGFloat {
        var width: CGFloat = 0.0
        if let image = self.image {
            width = height * image.size.width / image.size.height
        }

        return width
    }
}
