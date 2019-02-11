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
        let parameters: [String: String] = ["primary_release_date.gte": "2019-02-8", "primary_release_date.lte": "2019-12-30", "sort_by": "popularity.desc", "page": "\(page)"]
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
