//
//  Person.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 5/5/24.
//

import Foundation

struct Person: Codable, Hashable {
    let biography, birthday, deathday: String?
    let id: Int
    let name, placeOfBirth: String?
    let profilePath: String?
    let popularity: Double?
    var knownForDepartment: String?
    
    var role: PersonDepartmentType? {
        guard let knownForDepartment else { return nil }
        return PersonDepartmentType(rawValue: knownForDepartment.lowercased())
    }
    
    var mediaKey: String {
        "person.\(id)"
    }

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
        case biography, birthday, deathday, id, popularity
        case name
        case placeOfBirth = "place_of_birth"
        case profilePath = "profile_path"
        case knownForDepartment = "known_for_department"
    }
}
