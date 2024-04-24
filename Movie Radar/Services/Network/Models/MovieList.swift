//
//  MovieList.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 23/4/24.
//

import Foundation

struct MovieList: Codable {
    let page: Int
    var results: [Movie]
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page,
             results,
             totalPages = "total_pages"
    }

    init() {
        page = 0
        results = []
        totalPages = 1
    }
}
