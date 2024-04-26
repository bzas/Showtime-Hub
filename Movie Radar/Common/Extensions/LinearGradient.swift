//
//  LinearGradient.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 26/4/24.
//

import SwiftUI

extension LinearGradient {
    static let appGradient = LinearGradient(
        gradient: Gradient(colors: [.blue, .purple]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
