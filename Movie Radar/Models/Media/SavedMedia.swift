//
//  SavedMedia.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import Foundation
import SwiftData

@Model
class SavedMedia {
    @Attribute(.unique) var id: String = UUID().uuidString

    var type: MediaType
    var savedType: SavedType
    var detail: Media
    
    init(
        type: MediaType,
        savedType: SavedType,
        detail: Media
    ) {
        self.type = type
        self.savedType = savedType
        self.detail = detail
    }
}
