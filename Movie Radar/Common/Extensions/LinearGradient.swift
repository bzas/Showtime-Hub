//
//  LinearGradient.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 19/5/24.
//

import SwiftUI

extension LinearGradient {
    static let clear = LinearGradient(
        gradient: Gradient(colors: [.clear]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let black = LinearGradient(
        gradient: Gradient(colors: [.black]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
