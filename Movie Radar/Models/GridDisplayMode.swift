//
//  GridDisplayMode.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import Foundation

enum GridDisplayMode: CaseIterable {
    case fullScreen, list
    
    var title: String {
        switch self {
        case .fullScreen:
            "Full screen"
        case .list:
            "List"
        }
    }
}
