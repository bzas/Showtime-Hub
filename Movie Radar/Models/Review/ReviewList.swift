//
//  ReviewList.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import Foundation

struct ReviewList: Codable {
    let reviews: [Review]

    enum CodingKeys: String, CodingKey {
        case reviews = "results"
    }

    init() {
        reviews = []
    }
}
