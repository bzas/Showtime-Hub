//
//  WatchProviderList.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 4/6/24.
//

import Foundation

struct WatchProviderList: Codable {
    let id: Int
    let results: [String: WatchInfo]
}
