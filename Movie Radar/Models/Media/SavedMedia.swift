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

    var _type: String
    @Transient var type: MediaType {
        get { MediaType(rawValue: _type)! }
        set { _type = newValue.rawValue }
    }
    
    var _savedType: String
    @Transient var savedType: SavedType {
        get { SavedType(rawValue: _savedType)! }
        set { _savedType = newValue.rawValue }
    }
    
    var detail: Media
    
    init(
        type: MediaType,
        savedType: SavedType,
        detail: Media
    ) {
        self._type = type.rawValue
        self._savedType = savedType.rawValue
        self.detail = detail
    }
}
