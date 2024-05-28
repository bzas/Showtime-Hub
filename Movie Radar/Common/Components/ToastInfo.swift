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
    
    init(
        text: String,
        imageName: String,
        color: Color
    ) {
        self.id = UUID().uuidString
        self.text = text
        self.imageName = imageName
        self.color = color
    }
    
    static func == (lhs: ToastInfo, rhs: ToastInfo) -> Bool {
        lhs.id == rhs.id
    }
}
