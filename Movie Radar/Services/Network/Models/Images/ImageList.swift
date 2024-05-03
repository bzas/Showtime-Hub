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

    func transform(startIn index: Int) -> [MovieImage] {
        let subarray1 = Array(posters[0..<index])
        let subarray2 = Array(posters[index..<posters.endIndex])
        return subarray2 + subarray1
    }
}
