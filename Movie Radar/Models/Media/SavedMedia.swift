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
    
    var _savedType: String?
    @Transient var savedType: SavedType? {
        get {
            if let _savedType {
                return SavedType(rawValue: _savedType)
            }
            return nil
        }
        set { _savedType = newValue?.rawValue }
    }
    
    var userList: UserList?
    var detail: Media
    
    var savedDate: Date?
    let fallbackDate = Date(timeIntervalSinceReferenceDate: 739725525)
    
    init(
        type: MediaType,
        userList: UserList,
        detail: Media
    ) {
        self._type = type.rawValue
        self.userList = userList
        self.detail = detail
        self.savedDate = Date()
    }
}
