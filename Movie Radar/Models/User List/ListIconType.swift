//
//  ListIconType.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 20/6/24.
//

import Foundation

enum ListIconType: CaseIterable {
    case emoji, systemSymbol, upload
    
    var title: String {
        switch self {
        case .emoji:
            NSLocalizedString("Emoji", comment: "")
        case .systemSymbol:
            NSLocalizedString("Symbol", comment: "")
        case .upload:
            NSLocalizedString("Upload from gallery", comment: "")
        }
    }
}
