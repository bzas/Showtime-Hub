//
//  WatchProviderList.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 4/6/24.
//

import Foundation

struct WatchProviderList: Codable {
    private let id: Int
    private let results: [String: WatchInfo]
    
    var countryResults: WatchInfo? {
        if let countryCode = Locale.current.language.region?.identifier.uppercased() {
            return results[countryCode]
        }
        return nil
    }
}
