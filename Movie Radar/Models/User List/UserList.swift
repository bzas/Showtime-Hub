//
//  UserList.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 31/5/24.
//

import SwiftUI
import SwiftData

@Model
class UserList: Codable {
    @Attribute(.unique) let title: String?
    let imageName: String?
    let index: Int
    
    var _listType: String?
    @Transient var listType: UserListType {
        get { UserListType(rawValue: _listType ?? UserListType.defaultList.rawValue)! }
        set { _listType = newValue.rawValue }
    }
    
    enum CodingKeys: String, CodingKey {
        case title, 
             imageName,
             index,
             listType,
             _listType
    }
    
    init(
        title: String,
        imageName: String,
        index: Int,
        listType: UserListType
    ) {
        self.title = title
        self.imageName = imageName
        self.index = index
        self._listType = listType.rawValue
    }
    
    required init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.title = try? container?.decode(String.self, forKey: .title)
        self.imageName = try? container?.decode(String.self, forKey: .imageName)
        self.index = (try? container?.decode(Int.self, forKey: .index)) ?? 0
        self._listType = try? container?.decode(String.self, forKey: ._listType)

    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(title, forKey: .title)
        try? container.encode(imageName, forKey: .imageName)
        try? container.encode(index, forKey: .index)
        try? container.encode(_listType, forKey: ._listType)
    }
}
