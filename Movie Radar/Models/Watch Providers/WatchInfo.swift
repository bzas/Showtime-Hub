//
//  WatchInfo.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 4/6/24.
//

import Foundation

struct WatchInfo: Codable {
    let link: String
    private let buy, flatRate, free, rent: [ProviderInfo]?
    
    var all: [ProviderInfo] {
        let list = (buy ?? []) + (flatRate ?? []) + (free ?? []) + (rent ?? [])
        return Array(Set(list))
    }
    
    enum CodingKeys: String, CodingKey {
        case link, buy, free, rent
        case flatRate = "flatrate"
    }
}
