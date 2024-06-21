//
//  MediaType.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 16/5/24.
//

import Foundation

enum MediaType: String, Codable, CaseIterable {
    case all, movie, tv

    var isMovie: Bool {
        self == .movie
    }
    
    var title: String {
        switch self {
        case .movie:
            NSLocalizedString("Movies", comment: "")
        case .tv:
            NSLocalizedString("Series", comment: "")
        case .all:
            NSLocalizedString("All", comment: "")
        }
    }
    
    var titleSingular: String {
        switch self {
        case .movie:
            NSLocalizedString("Movie", comment: "")
        case .tv:
            NSLocalizedString("Series", comment: "")
        case .all:
            NSLocalizedString("All", comment: "")
        }
    }
}
