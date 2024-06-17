//
//  ListBackground.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 16/6/24.
//

import Foundation

enum ListBackground: String {
    case abstract, city, nature, sports
    
    func imagePath(index: Int) -> String {
        rawValue + "-\(index)"
    }
}
