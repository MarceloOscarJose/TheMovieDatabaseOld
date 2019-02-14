//
//  MovieModel.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 2/11/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class MovieModel: NSObject {

    var maxPages: Int = 2
    var currentPage: Int = 1

    func getUpcommingMovies(nextPage: Bool, responseHandler: @escaping (_ response: [MovieData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        if nextPage && maxPages > self.currentPage {
            self.currentPage += 1
            print(self.currentPage)
        }

        if maxPages > self.currentPage {
            fetchUpcommingMoviews(responseHandler: responseHandler, errorHandler: errorHandler)
        }
    }

    private func fetchUpcommingMoviews(responseHandler: @escaping (_ response: [MovieData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        let discoverService = DiscoverService()
        var movies: [MovieData] = []

        let formatter = DateFormatter.iso8601
        let dateGTE = formatter.string(from: Date())
        var dateLTE = ""

        var dateComponent = DateComponents()
        dateComponent.month = 1

        if let lteDateData = Calendar.current.date(byAdding: dateComponent, to: Date()) {
            dateLTE = formatter.string(from: lteDateData)
        }

        let parameters: [String: String] = [
            "primary_release_date.gte": dateGTE,
            "primary_release_date.lte": dateLTE,
            "sort_by": "popularity.desc",
            "region": "US",
            "page": "\(self.currentPage)"
        ]

        discoverService.fetchDiscoverService(parameters: parameters, responseHandler: { (movieResult) in
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
