//
//  Review.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import Foundation

struct Review: Codable, Hashable {
    let author: String?
    let id: String
    let content, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case author
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
    }
}
