//
//  MovieList.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 23/4/24.
//

import Foundation

struct MovieList: Codable {
    var page: Int
    var movies: [Movie]
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page,
             movies = "results",
             totalPages = "total_pages"
    }

    init() {
        page = 1
        movies = []
        totalPages = 1
    }

    mutating func append(_ movieList: MovieList) {
        page = movieList.page + 1
        let filteredMovies = movieList.movies.filter {
            !movies.contains($0)
        }
        movies.append(contentsOf: filteredMovies)
    }
}
