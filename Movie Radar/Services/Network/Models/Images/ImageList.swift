//
//  ImageList.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 2/5/24.
//

import Foundation

struct ImageList: Codable {
    let backdrops: [MovieImage]
    let logos, posters: [MovieImage]

    init() {
        backdrops = []
        logos = []
        posters = []
    }
}
