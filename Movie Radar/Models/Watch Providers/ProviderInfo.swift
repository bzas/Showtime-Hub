//
//  File.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 4/6/24.
//

import Foundation

struct ProviderInfo: Codable {
    let logoPath: String
    let providerId: Int
    let providerName: String
    let displayPriority: Int

    enum CodingKeys: String, CodingKey {
        case logoPath = "logo_path"
        case providerId = "provider_id"
        case providerName = "provider_name"
        case displayPriority = "display_priority"
    }
}
