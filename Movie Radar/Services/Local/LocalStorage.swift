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
        userList: UserList,
        searchText: String,
        startDate: Date,
        endDate: Date
    ) -> Predicate<SavedMedia> {
        let allMedia = MediaType.all.rawValue
        let mediaTypeString = mediaType.rawValue
        return #Predicate<SavedMedia> {
            ($0.userList?.id ?? "") == userList.id &&
            (mediaTypeString == allMedia ? true : $0._type == mediaTypeString) &&
            (searchText.isEmpty ? true : $0.detail.name.contains(searchText)) &&
            ((startDate != defaultDate) ? ($0.detail.date > startDate) : true) &&
            ((endDate != defaultEndDate) ? ($0.detail.date < endDate) : true)
        }
    }
    
    func fetchItems() -> [SavedMedia] {
        do {
            return try modelContext.fetch(FetchDescriptor<SavedMedia>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func insert(media: Media, type: MediaType, userList: UserList) {
        let savedMedia = SavedMedia(
            type: type,
            userList: userList,
            detail: media
        )
        modelContext.insert(savedMedia)
    }
    
    func delete(
        media: Media,
        mediaType: MediaType,
        userList: UserList,
        list: [SavedMedia]
    ) {
        if let itemToRemove = list.first(where: {
            $0.detail.id == media.id && $0.type == mediaType && $0.userList == userList
        }) {
            modelContext.delete(itemToRemove)
        }
    }
    
    func insert(list: UserList) {
        modelContext.insert(list)
    }
    
    func delete(
        list: UserList,
        mediaItems: [SavedMedia]
    ) {
        mediaItems
            .filter {
                $0.userList == list
            }
            .forEach {
                modelContext.delete($0)
            }
        
        modelContext.delete(list)
    }
}
