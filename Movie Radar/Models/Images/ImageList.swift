//
//  ImageList.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 2/5/24.
//

import Foundation

struct ImageList: Codable {
    let backdrops: [MediaImage]
    let logos, posters: [MediaImage]

    init() {
        backdrops = []
        logos = []
        posters = []
    }
}
