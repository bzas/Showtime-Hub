//
//  UserListType.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 31/5/24.
//

import Foundation

enum UserListType: String, Codable {
    case defaultList, myLists
    
    var title: String {
        switch self {
        case .defaultList:
            NSLocalizedString("Default", comment: "")
        case .myLists:
            NSLocalizedString("My lists", comment: "")
        }
    }
}
