//
//  MediaList.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 23/4/24.
//

import Foundation

struct MediaList: Codable {
    var page: Int
    var results: [Media]
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page,
             results,
             totalPages = "total_pages"
    }

    init() {
        page = 1
        results = []
        totalPages = 1
    }

    mutating func append(_ movieList: MediaList) {
        page = movieList.page + 1
        let filteredMovies = movieList.results.filter {
            !results.contains($0)
        }
        results.append(contentsOf: filteredMovies)
    }
}
