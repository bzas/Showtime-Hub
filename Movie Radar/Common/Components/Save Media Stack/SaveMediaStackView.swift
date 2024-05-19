//
//  SaveMediaStackView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 19/5/24.
//

import SwiftUI
import SwiftData

struct SaveMediaStackView: View {
    let media: Media
    let mediaType: MediaType
    let axis: Axis
    @State var triggerHapticFeedback = false
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \SavedMedia.detail.popularity, order: .forward) var mediaItems: [SavedMedia]
    
    var body: some View {
        
        if axis == .vertical {
            VStack {
                content()
            }
            .sensoryFeedback(
                .impact(flexibility: .soft, intensity: 1),
                trigger: triggerHapticFeedback
            )
        } else {
            HStack {
                content()
            }
            .sensoryFeedback(
                .impact(flexibility: .soft, intensity: 1),
                trigger: triggerHapticFeedback
            )
        }
    }
    
    @ViewBuilder func content() -> some View {
        
        ForEach(SavedType.allCases, id: \.self) { savedType in
            Button {
                addOrRemove(type: savedType)
            } label: {
                SaveMediaButtonView(
                    type: savedType,
                    isSaved: isSaved(type: savedType)
                )
            }
        }
    }
    
    func addOrRemove(type: SavedType) {
        if isSaved(type: type) {
            remove(savedType: type)
        } else {
            insert(savedType: type)
        }
        
        triggerHapticFeedback.toggle()
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
