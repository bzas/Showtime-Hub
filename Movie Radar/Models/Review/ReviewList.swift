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
    
    func transform(startIn index: Int) -> [Review] {
        let subarray1 = Array(reviews[0..<index])
        let subarray2 = Array(reviews[index..<reviews.endIndex])
        return subarray2 + subarray1
    }
}
