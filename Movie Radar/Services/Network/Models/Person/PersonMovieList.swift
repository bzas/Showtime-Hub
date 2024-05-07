//
//  PersonMovielist.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 6/5/24.
//

import Foundation

struct PersonMovieList: Codable {
    let cast, crew: [PersonMovie]

    var popularMovies: [PersonMovie] {
        cast.sorted { movie1, movie2 in
            (movie1.popularity ?? 0) > (movie2.popularity ?? 0)
        }
    }

    init() {
        cast = []
        crew = []
    }
}
