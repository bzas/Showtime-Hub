//
//  KeychainManager.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 28/4/24.
//

import SwiftUI
import SwiftData

class LocalStorage {
    static let appGradientKey = "AppGradient"
    
    var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func insert(media: Media, type: MediaType, savedType: SavedType) {
        let savedMedia = SavedMedia(
            type: type,
            savedType: savedType,
            detail: media
        )
        modelContext.insert(savedMedia)
    }
}
