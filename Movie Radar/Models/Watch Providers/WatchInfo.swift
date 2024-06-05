//
//  WatchInfo.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 4/6/24.
//

import Foundation

struct WatchInfo: Codable {
    let link: String
    let buy, flatRate, free, rent: [ProviderInfo]?
    
    enum CodingKeys: String, CodingKey {
        case link, buy, free, rent
        case flatRate = "flatrate"
    }
}
