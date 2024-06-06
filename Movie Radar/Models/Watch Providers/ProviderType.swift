//
//  ProviderType.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 6/6/24.
//

import Foundation

enum ProviderType: CaseIterable {
    case streaming,
         buy,
         rent,
         free
    
    var title: String {
        switch self {
        case .streaming:
            NSLocalizedString("Streaming", comment: "")
        case .buy:
            NSLocalizedString("Buy", comment: "")
        case .rent:
            NSLocalizedString("Rent", comment: "")
        case .free:
            NSLocalizedString("Free", comment: "")
        }
    }
}
