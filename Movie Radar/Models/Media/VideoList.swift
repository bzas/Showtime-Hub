//
//  MediaVideo.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 9/6/24.
//

import Foundation

struct VideoList: Codable {
    let results: [MediaVideo]?
    
    var trailerUrl: URL? {
        results?.filter({ $0.isYoutubeTrailer }).first?.youtubeUrl
    }
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct MediaVideo: Codable {
    let id: String
    let name, key: String?
    let site: String?
    let type: String?
    let official: Bool?
    let publishedAt: String?
    
    var isYoutubeTrailer: Bool {
        site == "YouTube" && (type == "Trailer")
    }
    
    var youtubeUrl: URL? {
        guard let key else { return nil }
        return URL(string: "https://www.youtube.com/watch?v=" + key)
    }

    enum CodingKeys: String, CodingKey {
        case name, key, site, type, official
        case publishedAt = "published_at"
        case id
    }
}
