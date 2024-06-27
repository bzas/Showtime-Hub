//
//  ListBackground.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 16/6/24.
//

import Foundation

enum ListBackgroundGenericType: String, CaseIterable {
    case app, upload
    
    var title: String {
        switch self {
        case .app:
            NSLocalizedString("App backgrounds", comment: "")
        case .upload:
            NSLocalizedString("Upload from gallery", comment: "")
        }
    }
}

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
    
    static let defaultPath = ListBackground.abstract.imagePath(index: 0)
    
    var pathItems: [String] {
        Array(0...9).map {
            imagePath(index: $0)
        }
    }
    
    func imagePath(index: Int) -> String {
        rawValue + "-\(index + 1)"
    }
    
    static func parse(path: String?) -> (ListBackground, Int) {
        let components = path?.components(separatedBy: "-")
        guard let components,
              components.count == 2,
              let type = ListBackground(rawValue: components[0]),
              let index = Int(components[1]) else {
            return (.abstract, 0)
        }
        
        return (type, index - 1)
    }
}
