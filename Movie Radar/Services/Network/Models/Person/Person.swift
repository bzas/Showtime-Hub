//
//  Person.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 5/5/24.
//

import Foundation

struct Person: Codable {
    let biography, birthday, deathday: String?
    let id: Int?
    let name, placeOfBirth: String?
    let profilePath: String?

    var imageUrl: URL? {
        guard let profilePath else { return nil }
        return URL(
            string: PathBuilder.image(
                type: .original,
                imagePath: profilePath
            )
        )
    }

    enum CodingKeys: String, CodingKey {
        case biography, birthday, deathday, id
        case name
        case placeOfBirth = "place_of_birth"
        case profilePath = "profile_path"
    }
}
