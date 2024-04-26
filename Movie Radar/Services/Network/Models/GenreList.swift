//
//  GenreList.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 26/4/24.
//

import Foundation

struct GenreList: Codable {
    let genres: [Genre]

    init() {
        genres = []
    }
}
