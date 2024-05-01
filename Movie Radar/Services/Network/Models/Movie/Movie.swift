//
//  Movie.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 23/4/24.
//

import Foundation

struct Movie: Codable, Hashable {
    let backdropPath: String?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int
    let imdbID: String?
    let originCountry: [String]?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue, runtime: Int?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    var posterImageUrl: URL? {
        guard let backdropPath else { return nil }
        return URL(
            string: PathBuilder.image(
                type: .poster,
                imagePath: backdropPath
            )
        )
    }

    var originalImageUrl: URL? {
        guard let posterPath else { return nil }
        return URL(
            string: PathBuilder.image(
                type: .original,
                imagePath: posterPath
            )
        )
    }

    var wideImageUrl: URL? {
        guard let backdropPath else { return nil }
        return URL(
            string: PathBuilder.image(
                type: .wide,
                imagePath: backdropPath
            )
        )
    }

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct ProductionCompany: Codable, Hashable {
    let logoPath, name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

struct ProductionCountry: Codable, Hashable {
    let name: String?

    enum CodingKeys: String, CodingKey {
        case name
    }
}
