//
//  SeriesGridSortType.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 16/5/24.
//

import Foundation

enum SeriesGridSortType: CaseIterable {
    case popularityDesc,
         name,
         releaseDateDesc,
         releaseDateAsc
    
    var requestKey: String {
        switch self {
        case .popularityDesc:
            "popularity.desc"
        case .name:
            "name.asc"
        case .releaseDateDesc:
            "first_air_date.desc"
        case .releaseDateAsc:
            "first_air_date.asc"
        }
    }
    
    var title: String {
        switch self {
        case .popularityDesc:
            "Popularity"
        case .name:
            "Name"
        case .releaseDateDesc:
            "Newest"
        case .releaseDateAsc:
            "Oldest"
        }
    }
}
