//
//  PersonDepartmentType.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 5/7/24.
//

import Foundation

enum PersonDepartmentType: String {
    case acting, directing, writing, art, production, camera, crew
    
    var title: String {
        switch self {
        case .acting:
            NSLocalizedString("Actor", comment: "")
        case .directing:
            NSLocalizedString("Director", comment: "")
        case .writing:
            NSLocalizedString("Writer", comment: "")
        case .art:
            NSLocalizedString("Artist", comment: "")
        case .production:
            NSLocalizedString("Producer", comment: "")
        case .camera:
            NSLocalizedString("Camera", comment: "")
        case .crew:
            NSLocalizedString("Crew", comment: "")
        }
    }
}
