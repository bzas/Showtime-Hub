//
//  ScrollOffsetPreferenceKey.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 9/6/24.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}
