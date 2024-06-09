//
//  SavedType.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI

enum SavedType: String, Codable, CaseIterable {
    case favorites, viewed, pending
    
    static let defaultLists: [UserList] = Self.allCases.map { $0.userList }
    
    var userList: UserList {
        UserList(
            title: title,
            imageName: fillImageName,
            index: index,
            listType: .defaultList,
            colorInfo: ColorInfo(color: color)
        )
    }
    
    var index: Int {
        switch self {
        case .favorites:
            0
        case .viewed:
            1
        case .pending:
            2
        }
    }
    
    var title: String {
        switch self {
        case .favorites:
            NSLocalizedString("Favorites", comment: "")
        case .viewed:
            NSLocalizedString("Viewed", comment: "")
        case .pending:
            NSLocalizedString("Pending", comment: "")
        }
    }
    
    var imageName: String {
        switch self {
        case .favorites:
            "heart"
        case .viewed:
            "eye"
        case .pending:
            "bookmark"
        }
    }
    
    var fillImageName: String {
        switch self {
        case .favorites:
            "heart.fill"
        case .viewed:
            "eye.fill"
        case .pending:
            "bookmark.fill"
        }
    }
    
    var addActionName: String {
        switch self {
        case .viewed:
            NSLocalizedString("Mark as Viewed", comment: "")
        default:
            String(
                format: NSLocalizedString("Add to %@", comment: ""),
                title
            )
        }
    }
    
    var removeActionName: String {
        String(
            format: NSLocalizedString("Remove from %@", comment: ""),
            title
        )
    }
    
    var color: Color {
        switch self {
        case .favorites:
            .red
        case .viewed:
            .blue
        case .pending:
            .orange
        }
    }
}
