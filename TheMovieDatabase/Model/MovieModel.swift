//
//  MovieModel.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 2/11/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class MovieModel: NSObject {

    func getUpcommingMovies(responseHandler: @escaping (_ response: [MovieData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        let movieService = DiscoverService()
        var movies: [MovieData] = []

        movieService.getUpcommingMovies(responseHandler: { (movieResult) in

            for movie in movieResult.results {
                movies.append(MovieData(movie: movie))
            }

            responseHandler(movies)
        }) { (error) in
            errorHandler(error)
        }
    }
}
