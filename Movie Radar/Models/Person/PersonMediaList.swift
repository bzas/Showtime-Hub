//
//  PersonMediaList.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 6/5/24.
//

import Foundation

struct PersonMediaList: Codable {
    let cast, crew: [PersonMedia]

    var popular: [PersonMedia] {
        cast.sorted {
            ($0.popularity ?? 0) > ($1.popularity ?? 0)
        }
    }

    init() {
        cast = []
        crew = []
    }
}
