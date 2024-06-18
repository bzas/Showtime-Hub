//
//  ListBackground.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 16/6/24.
//

import Foundation

enum ListBackground: String, CaseIterable {
    case abstract, city, nature, sports
    
    var title: String {
        switch self {
        case .abstract:
            NSLocalizedString("Abstract", comment: "")
        case .city:
            NSLocalizedString("City", comment: "")
        case .nature:
            NSLocalizedString("Nature", comment: "")
        case .sports:
            NSLocalizedString("Sports", comment: "")
        }
    }
    
    func imagePath(index: Int) -> String {
        rawValue + "-\(index)"
    }
    
    var pathItems: [String] {
        Array(1...10).map {
            imagePath(index: $0)
        }
    }
}
