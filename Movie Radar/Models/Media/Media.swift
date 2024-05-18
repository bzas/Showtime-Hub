//
//  Media.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 23/4/24.
//

import Foundation
import SwiftData

@Model
class Media: Codable, Hashable {
    static func == (lhs: Media, rhs: Media) -> Bool {
        lhs.uniqueId == rhs.uniqueId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uniqueId)
    }
    
    @Attribute(.unique) let uniqueId = UUID()
    let backdropPath: String?
    let budget: Int?
    let revenue: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int
    let imdbID: String?
    let originCountry: [String]?
    let originalLanguage: String?
    let overview: String?
    let originalTitle: String?
    let popularity: Double?
    let posterPath: String?
    let runtime: Int?
    let voteAverage: Double?
    let creators: [Person]?
    let seasons: [Season]?
    let seasonNumber: Int?
    let episodeNumber: Int?
    private let releaseDate: String?
    private let airDate: String?
    private let title: String?
    private let name: String?

    var date: String? {
        releaseDate ?? airDate
    }
    
    var publicName: String {
        title ?? name ?? ""
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
    
    convenience init(id: Int) {
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
            releaseDate: nil,
            airDate: nil,
            revenue: nil,
            runtime: nil,
            title: nil,
            voteAverage: nil,
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
        releaseDate: String?,
        airDate: String?,
        revenue: Int?,
        runtime: Int?,
        title: String?,
        voteAverage: Double?,
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
        self.releaseDate = releaseDate
        self.airDate = airDate
        self.revenue = revenue
        self.runtime = runtime
        self.title = title
        self.voteAverage = voteAverage
        self.name = name
        self.creators = creators
        self.seasons = seasons
        self.seasonNumber = seasonNumber
        self.episodeNumber = episodeNumber
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
        case releaseDate = "release_date"
        case revenue, runtime
        case voteAverage = "vote_average"
        case title
        case name
        case airDate = "first_air_date"
        case creators = "created_by"
        case seasons
        case seasonNumber = "number_of_seasons"
        case episodeNumber = "number_of_episodes"
    }
}
