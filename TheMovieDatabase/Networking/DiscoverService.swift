//
//  MovieService.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 2/8/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class DiscoverService: GeneralService {

    let discoverURL = "discover/movie/"

    func getUpcommingMovies(page: Int, responseHandler: @escaping (_ response: MovieResult) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

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
            "page": "\(page)"
        ]

        self.fetchDiscoverService(parameters: parameters, responseHandler: responseHandler, errorHandler: errorHandler)
    }

    func fetchDiscoverService(parameters: [String: String], responseHandler: @escaping (_ response: MovieResult) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        self.executeRequest(url: self.discoverURL, paramaters: parameters as [String : AnyObject], responseHandler: { (data) in
            do {
                let movieResult = try JSONDecoder().decode(MovieResult.self, from: data)
                responseHandler(movieResult)
            } catch {
                errorHandler(nil)
            }
        }) { (error) in
            errorHandler(error)
        }
    }
}
