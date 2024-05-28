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
    @Query(sort: [
        SortDescriptor(\SavedMedia.detail.name)
    ]) var mediaItems: [SavedMedia]
    
    var body: some View {
        ForEach(SavedType.allCases, id: \.self) { savedType in
            Button(role: buttonRole(type: savedType)) {
                addOrRemove(type: savedType)
            } label: {
                Label(
                    isSaved(type: savedType) ? savedType.removeActionName : savedType.addActionName,
                    systemImage: isSaved(type: savedType) ? savedType.fillImageName : savedType.imageName
                )
            }
        }
    }
    
    func buttonRole(type: SavedType) -> ButtonRole? {
        isSaved(type: type) ? .destructive : nil
    }
    
    func addOrRemove(type: SavedType) {
        if isSaved(type: type) {
            remove(savedType: type)
        } else {
            insert(savedType: type)
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
