//
//  ColorInfo.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 2/6/24.
//

import SwiftUI
import SwiftData

struct ColorInfo: Codable {
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    
    var color: Color {
        Color(
            red: red,
            green: green,
            blue: blue
        )
    }
    
    enum CodingKeys: String, CodingKey {
        case red, green, blue
    }
    
    init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(color: Color) {
        self.red = color.components.red
        self.green = color.components.green
        self.blue = color.components.blue
    }
}
