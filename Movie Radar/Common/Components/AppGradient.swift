//
//  LinearGradient.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 26/4/24.
//

import SwiftUI

enum AppGradient: String, CaseIterable, Codable {
    case white,
         bluePurple,
         blueGreen,
         yellowOrange,
         bluePink,
         yellow,
         pink

    var value: LinearGradient {
        switch self {
        case .bluePurple:
            LinearGradient(
                gradient: Gradient(colors: [.blue, .purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .blueGreen:
            LinearGradient(
                gradient: Gradient(colors: [.blue, .green]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .yellowOrange:
            LinearGradient(
                gradient: Gradient(colors: [.yellow, .orange]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .bluePink:
            LinearGradient(
                gradient: Gradient(colors: [.blue, .pink]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .yellow:
            LinearGradient(
                gradient: Gradient(colors: [.yellow]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .pink:
            LinearGradient(
                gradient: Gradient(colors: [.pink]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .white:
            LinearGradient(
                gradient: Gradient(colors: [.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    var plainColor: Color {
        switch self {
        case .bluePurple:
                .purple
        case .blueGreen:
            Color(
                red: 144 / 255,
                green: 206 / 255,
                blue: 161 / 255
            )
        case .yellowOrange:
                .yellow
        case .bluePink:
                .pink
        case .yellow:
                .yellow
        case .pink:
                .pink
        case .white:
                .white
        }
    }
}
