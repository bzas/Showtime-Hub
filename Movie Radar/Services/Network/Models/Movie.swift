//
//  Movie.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 23/4/24.
//

import Foundation

struct Movie: Codable, Hashable {
    let backdropPath: String?
    let id: Int?
    let title: String?
    let voteAverage: Double?
    let popularity: Double?
    let overview: String?
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case id,
             title,
             popularity,
             overview,
             backdropPath = "backdrop_path",
             voteAverage = "vote_average",
             releaseDate = "release_date"
    }

}
