//
//  MovieResult.swift
//  TheMovieDatabase
//
//  Created by Marcelo Oscar José on 2/11/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

struct MovieResult: Codable {

    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [Movie]

    enum CodingKeys: String, CodingKey
    {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }

    public struct Movie: Codable {

        var id: Int
        var voteCount: Int
        var video: Bool
        var voteAverage: Double
        var title: String
        var popularity: Double
        var posterPath: String?
        var originalLanguage: String
        var originalTitle: String
        var backdropPath: String?
        var overview: String
        var releaseDate: Date

        enum CodingKeys: String, CodingKey
        {
            case id
            case voteCount = "vote_count"
            case video
            case voteAverage = "vote_average"
            case title
            case popularity
            case posterPath = "poster_path"
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case backdropPath = "backdrop_path"
            case overview
            case releaseDate = "release_date"
        }
    }
}

extension MovieResult.Movie {

    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
        video = try container.decode(Bool.self, forKey: .video)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        title = try container.decode(String.self, forKey: .title)
        popularity = try container.decode(Double.self, forKey: .popularity)
        posterPath = try? container.decode(String.self, forKey: .posterPath)
        originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        originalTitle = try container.decode(String.self, forKey: .originalTitle)
        backdropPath = try? container.decode(String.self, forKey: .backdropPath)
        overview = try container.decode(String.self, forKey: .overview)

        let dateString = try container.decode(String.self, forKey: .releaseDate)
        let formatter = DateFormatter.iso8601
        if let date = formatter.date(from: dateString) {
            releaseDate = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .releaseDate, in: container, debugDescription: "Date string does not match format expected by formatter.")
        }
    }
}
