//
//  MovieService.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 2/8/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class MovieService: GeneralService {

    let upcommingURL = "movie/upcoming/"

    func fetchUpcommingService(page: Int, responseHandler: @escaping (_ response: MovieResult) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        let parameters: [String: String] = ["region": "US", "page": "\(page)"]
        self.executeRequest(url: self.upcommingURL, paramaters: parameters as [String : AnyObject], responseHandler: { (data) in
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
