//
//  SavedType.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import Foundation

enum SavedType: String {
    case favorites, viewed
    
    var title: String {
        switch self {
        case .favorites:
            "Favorites"
        case .viewed:
            "Viewed"
        }
    }
}
