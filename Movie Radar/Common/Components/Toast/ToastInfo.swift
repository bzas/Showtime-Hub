//
//  ToastInfo.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 28/5/24.
//

import SwiftUI

class ToastInfo: Equatable {
    let id: String
    let text: String
    let imageName: String
    let color: Color
    
    init(isRemoved: Bool) {
        self.id = UUID().uuidString
        text = isRemoved ? NSLocalizedString("List Removed", comment: "") : NSLocalizedString("List added", comment: "")
        imageName = isRemoved ? "trash.circle.fill" : "checkmark.circle.fill"
        color = isRemoved ? .red.opacity(0.75) : .green.opacity(0.75)
    }
    
    init(
        isSaved: Bool,
        userList: UserList
    ) {
        self.id = UUID().uuidString
        
        if isSaved {
            text = String(format: NSLocalizedString("Removed from %@", comment: ""), userList.title ?? "")
        } else {
            text = String(format: NSLocalizedString("Added to %@", comment: ""), userList.title ?? "")
        }

        imageName = isSaved ? "trash.circle.fill" : "checkmark.circle.fill"
        color = isSaved ? .red.opacity(0.75) : .green.opacity(0.75)
    }
    
    static func == (lhs: ToastInfo, rhs: ToastInfo) -> Bool {
        lhs.id == rhs.id
    }
}
