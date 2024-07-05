//
//  PersonList.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 4/7/24.
//

import Foundation

struct PersonList: Codable {
    let results: [Person]

    enum CodingKeys: String, CodingKey {
        case results
    }
}
