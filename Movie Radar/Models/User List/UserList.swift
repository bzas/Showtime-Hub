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
    @Attribute(.unique) let id = UUID().uuidString
    var title: String?
    var imageName: String?
    let index: Int
    var colorInfo: ColorInfo?
    var backgroundPath: String?
    var emoji: String?
    @Attribute(.externalStorage) var customImage: Data?

    var _listType: String?
    @Transient var listType: UserListType {
        get { UserListType(rawValue: _listType ?? UserListType.defaultList.rawValue)! }
        set { _listType = newValue.rawValue }
    }
    
    var addActionText: String {
        String(format: NSLocalizedString("Add to %@", comment: ""), title ?? "")
    }
    
    var removeActionText: String {
        String(format: NSLocalizedString("Remove from %@", comment: ""), title ?? "")
    }
    
    enum CodingKeys: String, CodingKey {
        case id,
             title,
             imageName,
             index,
             listType,
             _listType,
             colorInfo,
             backgroundPath,
             emoji,
             customImage
    }
    
    init(
        title: String,
        imageName: String? = nil,
        index: Int,
        listType: UserListType,
        colorInfo: ColorInfo? = nil,
        backgroundPath: String?,
        emoji: String? = nil,
        customImage: Data? = nil
    ) {
        self.title = title
        self.imageName = imageName
        self.index = index
        self._listType = listType.rawValue
        self.colorInfo = colorInfo
        self.backgroundPath = backgroundPath
        self.emoji = emoji
        self.customImage = customImage
    }
    
    required init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.id = (try? container?.decode(String.self, forKey: .id)) ?? UUID().uuidString
        self.title = try? container?.decode(String.self, forKey: .title)
        self.imageName = try? container?.decode(String.self, forKey: .imageName)
        self.index = (try? container?.decode(Int.self, forKey: .index)) ?? 0
        self._listType = try? container?.decode(String.self, forKey: ._listType)
        self.colorInfo = (try? container?.decode(ColorInfo.self, forKey: .colorInfo)) ?? ColorInfo(color: .white)
        self.backgroundPath = (try? container?.decode(String.self, forKey: .backgroundPath))
        self.emoji = (try? container?.decode(String.self, forKey: .emoji))
        self.customImage = (try? container?.decode(Data.self, forKey: .customImage))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(id, forKey: .id)
        try? container.encode(title, forKey: .title)
        try? container.encode(imageName, forKey: .imageName)
        try? container.encode(index, forKey: .index)
        try? container.encode(_listType, forKey: ._listType)
        try? container.encode(colorInfo, forKey: .colorInfo)
        try? container.encode(backgroundPath, forKey: .backgroundPath)
        try? container.encode(emoji, forKey: .emoji)
        try? container.encode(customImage, forKey: .customImage)
    }
    
    func actionTitle(isSaved: Bool) -> String {
        isSaved ? removeActionText : addActionText
    }
}
