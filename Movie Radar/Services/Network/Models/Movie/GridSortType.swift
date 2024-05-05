//
//  GridSortType.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 5/5/24.
//

import Foundation

enum GridSortType: CaseIterable {
    case popularityDesc,
         name,
         releaseDate,
         revenue

    var requestKey: String {
        switch self {
        case .popularityDesc:
            "popularity.desc"
        case .name:
            "title.asc"
        case .releaseDate:
            "primary_release_date.desc"
        case .revenue:
            "revenue.desc"
        }
    }

    var title: String {
        switch self {
        case .popularityDesc:
            "Popularity"
        case .name:
            "Name"
        case .releaseDate:
            "Release date"
        case .revenue:
            "Revenue"
        }
    }
}
