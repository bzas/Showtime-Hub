//
//  File.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 4/6/24.
//

import Foundation

struct ProviderInfo: Codable, Hashable {
    let logoPath: String?
    let providerId: Int
    let providerName: String?
    let displayPriority: Int?
    
    var imageUrl: URL? {
        guard let logoPath else { return nil }
        return URL(
            string: PathBuilder.image(
                type: .original,
                imagePath: logoPath
            )
        )
    }

    enum CodingKeys: String, CodingKey {
        case logoPath = "logo_path"
        case providerId = "provider_id"
        case providerName = "provider_name"
        case displayPriority = "display_priority"
    }
}
