//
//  MediaType.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 16/5/24.
//

import Foundation

enum MediaType: String {
    case movie, tv

    var isMovie: Bool {
        self == .movie
    }
}
