//
//  MediaContextMenu.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 17/5/24.
//

import SwiftUI
import SwiftData

struct MediaContextMenu: View {
    let media: Media
    let mediaType: MediaType
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \SavedMedia.detail.popularity, order: .forward) var mediaItems: [SavedMedia]

    var body: some View {
        Button {
            if isSaved(type: .favorites) {
                remove(savedType: .favorites)
            } else {
                insert(savedType: .favorites)
            }
        } label: {
            HStack {
                Image(systemName: isSaved(type: .favorites) ? "heart.fill" : "heart")
                Text(isSaved(type: .favorites) ? "Remove from Favorites" : "Add to Favorites")
            }
        }

        Button {
            if isSaved(type: .viewed) {
                remove(savedType: .viewed)
            } else {
                insert(savedType: .viewed)
            }
        } label: {
            HStack {
                Image(systemName: isSaved(type: .viewed) ? "checkmark.square.fill" : "checkmark.square")
                Text(isSaved(type: .viewed) ? "Remove from viewed" : "Mark as viewed")
            }
        }
    }
    
    func isSaved(type: SavedType) -> Bool {
        mediaItems.contains {
            $0.detail.id == media.id && $0.savedType == type
        }
    }
    
    func insert(savedType: SavedType) {
        let storage = LocalStorage(modelContext: modelContext)
        storage.insert(
            media: media,
            type: mediaType,
            savedType: savedType
        )
    }
    
    func remove(savedType: SavedType) {
        let storage = LocalStorage(modelContext: modelContext)
        storage.delete(
            media: media,
            mediaType: mediaType,
            savedType: savedType,
            list: mediaItems
        )
    }
}
