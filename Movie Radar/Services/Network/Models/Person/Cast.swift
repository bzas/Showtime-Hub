//
//  Cast.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 30/4/24.
//

import Foundation

struct Cast: Codable, Hashable {
    let id: Int
    let gender: Int?
    let knownForDepartment: String?
    let name, originalName: String?
    let popularity: Double
    let profilePath: String?
    let character: String?
    let creditId: String?

    var imageUrl: URL? {
        guard let profilePath else { return nil }
        return URL(
            string: PathBuilder.image(
                type: .square,
                imagePath: profilePath
            )
        )
    }

    enum CodingKeys: String, CodingKey {
        case gender, id
        case creditId = "credit_id"
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case character
    }
}
