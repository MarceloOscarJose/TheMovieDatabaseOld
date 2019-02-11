//
//  MovieModel.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 2/11/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class MovieModel: NSObject {

    var maxPages: Int = 0
    var currentPage: Int = 1

    func getUpcommingMovies(nextPage: Bool, responseHandler: @escaping (_ response: [MovieData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        let discoverService = DiscoverService()
        var movies: [MovieData] = []

        if nextPage && maxPages > self.currentPage {
            self.currentPage += 1
            print(self.currentPage)
        }

        discoverService.getUpcommingMovies(page: self.currentPage, responseHandler: { (movieResult) in
            self.maxPages = movieResult.totalPages
            for movie in movieResult.results {
                movies.append(MovieData(movie: movie))
            }

            responseHandler(movies)
        }) { (error) in
            errorHandler(error)
        }
    }
}
