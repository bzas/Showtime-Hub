//
//  ListIconType.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 20/6/24.
//

import Foundation

enum ListIconType: CaseIterable {
    case systemSymbol, emoji
    
    var title: String {
        switch self {
        case .emoji:
            NSLocalizedString("Emoji", comment: "")
        case .systemSymbol:
            NSLocalizedString("System icon", comment: "")
        }
    }
}
