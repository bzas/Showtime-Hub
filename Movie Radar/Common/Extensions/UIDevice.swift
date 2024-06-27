//
//  UIDevice.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 27/6/24.
//

import UIKit

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
