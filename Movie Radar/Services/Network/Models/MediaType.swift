//
//  MediaType.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 16/5/24.
//

import Foundation

enum MediaType: String {
    case movie, tv
    
    var discoverPath: Path {
        switch self {
        case .movie:
            .discover
        case .tv:
            .discoverTv
        }
    }
    
    var searchPath: Path {
        switch self {
        case .movie:
            .search
        case .tv:
            .searchTv
        }
    }
    
    var genresPath: Path {
        switch self {
        case .movie:
            .genres
        case .tv:
            .genresTv
        }
    }
    
}
