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
    
    @Attribute(.unique) 
    let uniqueId = UUID()
    let name: String
    let backdropPath: String?
    let budget: Int?
    let revenue: Int?
    let genres: [Genre]?
    let id: Int
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let runtime: Int?
    let voteCount: Int?
    let creators: [Person]?
    let seasons: [Season]?
    let seasonNumber: Int?
    let episodeNumber: Int?
    let date: Date
    let videoList: VideoList?
    
    private let releaseDate: String?
    private let airDate: String?
    private let voteAverage: Double?

    var totalVoteAverage: Double? {
        (voteCount ?? 0) > 0 ? voteAverage : nil
    }

    var dateString: String? {
        releaseDate ?? airDate
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
    
    var originalWideImageUrl: URL? {
        guard let backdropPath else { return nil }
        return URL(
            string: PathBuilder.image(
                type: .original,
                imagePath: backdropPath
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
        case budget
        case genres
        case id
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case title
        case name
        case airDate = "first_air_date"
        case creators = "created_by"
        case seasons
        case seasonNumber = "number_of_seasons"
        case episodeNumber = "number_of_episodes"
        case date
        case videoList = "videos"
    }
    
    convenience init(id: Int) {
        self.init(
            backdropPath: nil,
            budget: nil,
            genres: nil,
            id: id,
            overview: nil,
            popularity: nil,
            posterPath: nil,
            releaseDate: nil,
            airDate: nil,
            revenue: nil,
            runtime: nil,
            voteAverage: nil,
            voteCount: nil,
            name: nil,
            creators: nil,
            seasons: nil, 
            seasonNumber: nil,
            episodeNumber: nil,
            date: Date(),
            videoList: VideoList(results: [])
        )
    }

    init(
        backdropPath: String?,
        budget: Int?,
        genres: [Genre]?,
        id: Int,
        overview: String?,
        popularity: Double?,
        posterPath: String?,
        releaseDate: String?,
        airDate: String?,
        revenue: Int?,
        runtime: Int?,
        voteAverage: Double?,
        voteCount: Int?,
        name: String?,
        creators: [Person]?,
        seasons: [Season]?, 
        seasonNumber: Int?,
        episodeNumber: Int?,
        date: Date,
        videoList: VideoList?
    ) {
        self.backdropPath = backdropPath
        self.budget = budget
        self.genres = genres
        self.id = id
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.airDate = airDate
        self.revenue = revenue
        self.runtime = runtime
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.name = name ?? ""
        self.creators = creators
        self.seasons = seasons
        self.seasonNumber = seasonNumber
        self.episodeNumber = episodeNumber
        self.date = date
        self.videoList = videoList
    }
    
    required init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.backdropPath = try? container?.decode(String.self, forKey: .backdropPath)
        self.budget = try? container?.decode(Int.self, forKey: .budget)
        self.genres = try? container?.decode([Genre].self, forKey: .genres)
        self.id = try container?.decode(Int.self, forKey: .id) ?? 0
        self.overview = try? container?.decode(String.self, forKey: .overview)
        self.popularity = try? container?.decode(Double.self, forKey: .popularity)
        self.posterPath = try? container?.decode(String.self, forKey: .posterPath)
        self.revenue = try? container?.decode(Int.self, forKey: .revenue)
        self.runtime = try? container?.decode(Int.self, forKey: .runtime)
        self.voteAverage = try? container?.decode(Double.self, forKey: .voteAverage)
        self.voteCount = try? container?.decode(Int.self, forKey: .voteCount)
        if let name = try? container?.decode(String.self, forKey: .name) {
            self.name = name
        } else if let title = try? container?.decode(String.self, forKey: .title) {
            self.name = title
        } else {
            self.name = ""
        }
        self.creators = try? container?.decode([Person].self, forKey: .creators)
        self.seasons = try? container?.decode([Season].self, forKey: .seasons)
        self.seasonNumber = try? container?.decode(Int.self, forKey: .seasonNumber)
        self.episodeNumber = try? container?.decode(Int.self, forKey: .episodeNumber)
        self.videoList = try? container?.decode(VideoList.self, forKey: .videoList)

        let releaseDate = try? container?.decode(String.self, forKey: .releaseDate)
        self.releaseDate = releaseDate
        
        let airDate = try? container?.decode(String.self, forKey: .airDate)
        self.airDate = airDate
        
        if let dateString = releaseDate ?? airDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd"
            self.date = formatter.date(from: dateString) ?? Date()
        } else {
            self.date = Date()
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(backdropPath, forKey: .backdropPath)
        try? container.encode(budget, forKey: .budget)
        try? container.encode(genres, forKey: .genres)
        try? container.encode(id, forKey: .id)
        try? container.encode(overview, forKey: .overview)
        try? container.encode(popularity, forKey: .popularity)
        try? container.encode(posterPath, forKey: .posterPath)
        try? container.encode(releaseDate, forKey: .releaseDate)
        try? container.encode(airDate, forKey: .airDate)
        try? container.encode(revenue, forKey: .revenue)
        try? container.encode(runtime, forKey: .runtime)
        try? container.encode(voteAverage, forKey: .voteAverage)
        try? container.encode(voteCount, forKey: .voteCount)
        try? container.encode(name, forKey: .name)
        try? container.encode(creators, forKey: .creators)
        try? container.encode(seasons, forKey: .seasons)
        try? container.encode(seasonNumber, forKey: .seasonNumber)
        try? container.encode(episodeNumber, forKey: .episodeNumber)
        try? container.encode(date, forKey: .date)
        try? container.encode(videoList, forKey: .videoList)
    }
    
    func mediaKey(type: MediaType) -> String {
        "\(id).\(type.rawValue)"
    }
}
