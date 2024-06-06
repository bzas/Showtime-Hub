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
    
    func providerList(type: ProviderType) -> [ProviderInfo] {
        switch type {
        case .streaming:
            flatRate ?? []
        case .buy:
            buy ?? []
        case .rent:
            rent ?? []
        case .free:
            free ?? []
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case link, buy, free, rent
        case flatRate = "flatrate"
    }
}
