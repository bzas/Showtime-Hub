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
    
    func filteredList(_ movieList: MediaList) -> [Media] {
        movieList.results.filter {
            !results.contains($0)
        }
    }

    mutating func append(_ newResults: [Media]) {
        page += 1
        results.append(contentsOf: newResults)
    }
}
