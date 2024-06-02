//
//  KeychainManager.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 28/4/24.
//

import SwiftUI
import SwiftData

class LocalStorage {
    static let defaultDate = Date(timeIntervalSince1970: -2208950000)
    static let defaultEndDate = Date()
    static let appGradientKey = "AppGradient"

    var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    static func buildFilterPredicate(
        mediaType: MediaType,
        savedType: SavedType,
        searchText: String,
        startDate: Date,
        endDate: Date
    ) -> Predicate<SavedMedia> {
        let allMedia = MediaType.all.rawValue
        let savedTypeString = savedType.rawValue
        let mediaTypeString = mediaType.rawValue
        return #Predicate<SavedMedia> {
            $0._savedType == savedTypeString &&
            (mediaTypeString == allMedia ? true : $0._type == mediaTypeString) &&
            (searchText.isEmpty ? true : $0.detail.name.contains(searchText)) &&
            $0.detail.date > startDate && $0.detail.date < endDate
        }
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
    
    func insert(list: UserList) {
        modelContext.insert(list)
    }
}
