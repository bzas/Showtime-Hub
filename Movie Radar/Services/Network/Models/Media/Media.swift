//
//  Media.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 23/4/24.
//

import Foundation

struct Media: Codable, Hashable {
    let backdropPath: String?
    let budget, revenue: Int?
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
    let runtime: Int?
    let status, tagline: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let creators: [Person]?
    let seasons: [Season]?
    let seasonNumber: Int?
    let episodeNumber: Int?
    private let releaseDate, airDate: String?
    private let title, name: String?

    var date: String? {
        releaseDate ?? airDate
    }
    
    var publicName: String {
        title ?? name ?? ""
    }
    
    init(id: Int) {
        self.init(
            backdropPath: nil,
            budget: nil,
            genres: nil,
            homepage: nil,
            id: id,
            imdbID: nil,
            originCountry: nil,
            originalLanguage: nil,
            originalTitle: nil,
            overview: nil,
            popularity: nil,
            posterPath: nil,
            productionCompanies: nil,
            productionCountries: nil,
            releaseDate: nil,
            airDate: nil,
            revenue: nil,
            runtime: nil,
            status: nil,
            tagline: nil,
            title: nil,
            video: nil,
            voteAverage: nil,
            voteCount: nil,
            name: nil,
            creators: nil,
            seasons: nil, 
            seasonNumber: nil,
            episodeNumber: nil
        )
    }

    init(
        backdropPath: String?,
        budget: Int?,
        genres: [Genre]?,
        homepage: String?,
        id: Int,
        imdbID: String?,
        originCountry: [String]?,
        originalLanguage: String?,
        originalTitle: String?,
        overview: String?,
        popularity: Double?,
        posterPath: String?,
        productionCompanies: [ProductionCompany]?,
        productionCountries: [ProductionCountry]?,
        releaseDate: String?,
        airDate: String?,
        revenue: Int?,
        runtime: Int?,
        status: String?,
        tagline: String?,
        title: String?,
        video: Bool?,
        voteAverage: Double?,
        voteCount: Int?,
        name: String?,
        creators: [Person]?,
        seasons: [Season]?, 
        seasonNumber: Int?,
        episodeNumber: Int?
    ) {
        self.backdropPath = backdropPath
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.imdbID = imdbID
        self.originCountry = originCountry
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.releaseDate = releaseDate
        self.airDate = airDate
        self.revenue = revenue
        self.runtime = runtime
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.name = name
        self.creators = creators
        self.seasons = seasons
        self.seasonNumber = seasonNumber
        self.episodeNumber = episodeNumber
    }

    var hasInfo: Bool {
        backdropPath != nil && overview != nil
    }

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
        case name
        case airDate = "first_air_date"
        case creators = "created_by"
        case seasons
        case seasonNumber = "number_of_seasons"
        case episodeNumber = "number_of_episodes"
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
