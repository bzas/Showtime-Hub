//
//  Int.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 8/6/24.
//

import Foundation

extension Int {
    
    var money: String {
        guard self > 0 else { return "-" }
        
        var formatString = NSLocalizedString("%.1fM", comment: "")
        var moneyNumber = Float(self) / 1000000.0
        if moneyNumber > 1000 {
            moneyNumber  = moneyNumber / 1000.0
            formatString = NSLocalizedString("%.1fB", comment: "")
        }
        
        return String(
            format: formatString,
            moneyNumber
        )
    }
}
