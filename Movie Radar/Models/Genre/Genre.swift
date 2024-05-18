//
//  Genre.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 26/4/24.
//

import Foundation
import SwiftData

struct Genre: Codable, Hashable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
