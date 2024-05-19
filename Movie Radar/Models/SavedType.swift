//
//  SavedType.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import Foundation

enum SavedType: String, Codable, CaseIterable {
    case favorites, viewed, pending
    
    var title: String {
        switch self {
        case .favorites:
            "Favorites"
        case .viewed:
            "Viewed"
        case .pending:
            "Pending"
        }
    }
    
    var imageName: String {
        switch self {
        case .favorites:
            "heart"
        case .viewed:
            "eye"
        case .pending:
            "bookmark"
        }
    }
    
    var fillImageName: String {
        switch self {
        case .favorites:
            "heart.fill"
        case .viewed:
            "eye.fill"
        case .pending:
            "bookmark.fill"
        }
    }
    
    var addActionName: String {
        switch self {
        case .favorites:
            "Add to Favorites"
        case .viewed:
            "Add to Viewed"
        case .pending:
            "Add to Pending"
        }
    }
    
    var removeActionName: String {
        switch self {
        case .favorites:
            "Remove from Favorites"
        case .viewed:
            "Remove from Viewed"
        case .pending:
            "Remove from Pending"
        }
    }
}
