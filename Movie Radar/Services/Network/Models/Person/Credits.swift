//
//  CastList.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 30/4/24.
//

import Foundation

struct Credits: Codable {
    let id: Int
    let cast, crew: [Cast]

    var actors: [Cast] {
        cast.filter {
            $0.knownForDepartment == "Acting"
        }
    }

    var director: Cast? {
        crew
            .filter {
                $0.knownForDepartment == "Directing"
            }
            .sorted {
                $0.popularity > $1.popularity
            }.first
    }
}
