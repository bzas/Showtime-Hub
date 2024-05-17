//
//  MovieGridSortType.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 5/5/24.
//

import Foundation

enum MovieGridSortType: CaseIterable {
    case popularityDesc,
         name,
         releaseDateDesc,
         releaseDateAsc,
         revenue

    var requestKey: String {
        switch self {
        case .popularityDesc:
            "popularity.desc"
        case .name:
            "title.asc"
        case .releaseDateDesc:
            "primary_release_date.desc"
        case .releaseDateAsc:
            "primary_release_date.asc"
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
        case .releaseDateDesc:
            "Newest"
        case .releaseDateAsc:
            "Oldest"
        case .revenue:
            "Revenue"
        }
    }
}