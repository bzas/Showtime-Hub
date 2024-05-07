//
//  PersonMovie.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 6/5/24.
//

import Foundation

struct PersonMovie: Codable, Hashable {
    let backdropPath: String?
    let genreIdS: [Int]?
    let id: Int?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate, title: String?
    let character: String?

    var imageUrl: URL? {
        guard let posterPath else { return nil }
        return URL(
            string: PathBuilder.image(
                type: .wide,
                imagePath: posterPath
            )
        )
    }

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genreIdS = "genre_ids"
        case id
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case character
    }
}
