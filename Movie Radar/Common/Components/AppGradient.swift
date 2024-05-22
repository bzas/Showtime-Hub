//
//  LinearGradient.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 26/4/24.
//

import SwiftUI

enum AppGradient: String, CaseIterable, Codable {
    case white,
         yellow,
         cyan,
         pink,
         blue,
         green,
         bluePurple,
         blueGreen,
         yellowOrange,
         bluePink

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
        case .blue:
            LinearGradient(
                gradient: Gradient(colors: [.blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .green:
            LinearGradient(
                gradient: Gradient(colors: [.green]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .cyan:
            LinearGradient(
                gradient: Gradient(colors: [.cyan]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}
