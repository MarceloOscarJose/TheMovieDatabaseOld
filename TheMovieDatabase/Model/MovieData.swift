//
//  MovieData.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 2/11/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class MovieData: NSObject {

    var id: Int
    var title: String
    var votes: Int
    var voteAverage: Double
    var popularity: Double
    var poster: String
    var backdrop: String?
    var overview: String
    var releaseDate: String

    init(movie: MovieResult.Movie) {
        self.id = movie.id
        self.title = movie.title
        self.votes = movie.voteCount
        self.voteAverage = movie.voteAverage
        self.popularity = movie.popularity
        self.poster = "\(ConfigManager.sharedInstance.imagesURL)\(movie.posterPath)"

        if let backdrop = movie.backdropPath {
            self.backdrop = "\(ConfigManager.sharedInstance.imagesURL)\(backdrop)"
        }

        self.overview = movie.overview

        let formatter = DateFormatter.longDate
        self.releaseDate = formatter.string(from: movie.releaseDate)
    }
}
