//
//  CarouselType.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 28/4/24.
//

import Foundation

enum MovieCarouselType {
    case popular,
         topRated,
         upcoming

    var title: String {
        switch self {
        case .popular:
            return "Popular"
        case .topRated:
            return "Top rated"
        case .upcoming:
            return "Upcoming"
        }
    }
}
