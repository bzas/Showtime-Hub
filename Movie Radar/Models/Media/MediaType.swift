//
//  MediaType.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 16/5/24.
//

import Foundation

enum MediaType: String {
    case movie, tv, all

    var isMovie: Bool {
        self == .movie
    }
    
    var title: String {
        switch self {
        case .movie:
            "Movies"
        case .tv:
            "Series"
        case .all:
            "All"
        }
    }
}
