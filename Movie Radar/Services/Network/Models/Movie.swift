//
//  Movie.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 23/4/24.
//

import Foundation

struct Movie: Codable, Hashable {
    let backdropPath: String?
    let genreIds: [Int] = []
    let id: Int?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    var imageUrl: URL? {
        guard let backdropPath else { return nil }
        return URL(string: PathBuilder.image(imagePath: backdropPath))
    }

    var wideImageUrl: URL? {
        guard let backdropPath else { return nil }
        return URL(string: PathBuilder.wideImage(imagePath: backdropPath))
    }

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
