//
//  SavedMediaItemCount.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 19/5/24.
//

import SwiftUI
import SwiftData

struct SavedMediaItemCount: View {
    var viewModel: SavedMediaView.ViewModel
    @Query var mediaItems: [SavedMedia]
    
    init(viewModel: SavedMediaView.ViewModel) {
        self.viewModel = viewModel
        _mediaItems = Query(
            filter: viewModel.filtersPredicate(savedType: viewModel.currentSavedType),
            sort: \SavedMedia.detail.name
        )
    }

    var body: some View {
        let filteredCount = mediaItems.count
        let displayCount = filteredCount == 1 ? "\(filteredCount) item" : "\(filteredCount) items"
        Text(displayCount)
            .font(.system(size: 12, weight: .light))
            .animation(.smooth)
    }
}
