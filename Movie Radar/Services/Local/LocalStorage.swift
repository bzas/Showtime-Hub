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
    
    func fetchItems() -> [SavedMedia] {
        do {
            return try modelContext.fetch(FetchDescriptor<SavedMedia>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func insert(media: Media, type: MediaType, savedType: SavedType) {
        let savedMedia = SavedMedia(
            type: type,
            savedType: savedType,
            detail: media
        )
        modelContext.insert(savedMedia)
    }
    
    func delete(
        media: Media,
        mediaType: MediaType,
        savedType: SavedType,
        list: [SavedMedia]
    ) {
        if let itemToRemove = list.first(where: {
            $0.detail.id == media.id && $0.type == mediaType && $0.savedType == savedType
        }) {
            modelContext.delete(itemToRemove)
        }
    }
}
