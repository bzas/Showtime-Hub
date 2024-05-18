//
//  Season.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import Foundation

struct Season: Codable, Hashable {
    let airDate: String?
    let episodeCount, id: Int?
    let name, overview, posterPath: String?
    let seasonNumber: Int?
    
    var imageUrl: URL? {
        guard let posterPath else { return nil }
        return URL(
            string: PathBuilder.image(
                type: .poster,
                imagePath: posterPath
            )
        )
    }

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}
