//
//  MovieModel.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 2/11/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class MovieModel: NSObject {

    var movies: [MovieData] = []
    let movieService = MovieService()

    var moviePageData: [String: PageData] = [
        "popular": PageData(),
        "toprated": PageData(),
        "upcomming": PageData()
    ]

    func getUpcommingMovies(nextPage: Bool, responseHandler: @escaping (_ response: [MovieData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        if let pageData = moviePageData["upcomming"] {
            if checkServicePage(moviePageData: pageData, nextPage: nextPage) {

                movieService.fetchUpcommingService(page: pageData.currentPage, responseHandler: { (movieResult) in
                    pageData.maxPages = movieResult.totalPages
                    for movie in movieResult.results {
                        self.movies.append(MovieData(movie: movie))
                    }

                    responseHandler(self.movies)
                }) { (error) in
                    errorHandler(error)
                }
            }
        }
    }

    func checkServicePage(moviePageData: PageData, nextPage: Bool) -> Bool {
        if nextPage && moviePageData.maxPages > moviePageData.currentPage {
            moviePageData.currentPage += 1
            print(moviePageData.currentPage)
        }

        if moviePageData.maxPages == moviePageData.currentPage {
            if !moviePageData.isFinalPage {
                moviePageData.isFinalPage = true
                return true
            }

            return false
        }

        return true
    }
}
