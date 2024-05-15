//
//  AppIcon.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 9/5/24.
//

import Foundation
// swiftlint:disable identifier_name

enum AppIcon: String, CaseIterable {
    case AppIcon,
         AppIcon2,
         AppIcon3,
         AppIcon4,
         AppIcon5,
         AppIcon6

    var path: String {
        rawValue + "-Preview"
    }
}
// swiftlint:enable identifier_name
