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

    var body: some View {
        Button {
            insert(savedType: .favorites)
        } label: {
            HStack {
                Image(systemName: "heart")
                Text("Add to Favorites")
            }
        }

        Button {
            insert(savedType: .viewed)
        } label: {
            HStack {
                Image(systemName: "checkmark.square")
                Text("Mark as viewed")
            }
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
}
