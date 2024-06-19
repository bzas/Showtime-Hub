//
//  DeleteItemMenu.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 19/6/24.
//

import SwiftUI
import SwiftData

struct DeleteItemMenu: View {
    let media: SavedMedia
    let userList: UserList
    @Query var mediaItems: [SavedMedia]
    @Environment(\.modelContext) var modelContext
    
    init(
        media: SavedMedia,
        userList: UserList
    ) {
        self.media = media
        self.userList = userList
        let mediaId = media.detail.id
        
        _mediaItems = Query(
            filter: #Predicate<SavedMedia> {
                $0.detail.id == mediaId
            },
            sort: [
                SortDescriptor(\SavedMedia.detail.name)
            ]
        )
    }
    
    var body: some View {
        Button(role: .destructive) {
            removeFromList()
        } label: {
            Label(
                "Delete",
                systemImage: "trash"
            )
        }
    }
    
    func removeFromList() {
        let storage = LocalStorage(modelContext: modelContext)
        storage.delete(
            media: media.detail,
            mediaType: media.type,
            userList: userList,
            list: mediaItems
        )
    }
}
