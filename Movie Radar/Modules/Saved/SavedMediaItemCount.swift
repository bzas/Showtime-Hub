//
//  SavedMediaItemCount.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 19/5/24.
//

import SwiftUI
import SwiftData

struct SavedMediaItemCount: View {
    @EnvironmentObject var viewModel: SavedMediaView.ViewModel
    @Query(sort: \SavedMedia.detail.popularity, order: .forward) var mediaItems: [SavedMedia]
    @Binding var selectedTab: Int
    
    var currentSavedType: SavedType {
        SavedType.allCases.enumerated().first { (index, savedType) in
            index == selectedTab
        }?.element ?? .favorites
    }

    var body: some View {
        let filteredCount = viewModel.items(
            items: mediaItems,
            savedType: currentSavedType
        ).count
        
        HStack {
            let displayCount = filteredCount == 1 ? "\(filteredCount) item saved" : "\(filteredCount) items saved"
            Text(displayCount)
                .font(.system(size: 14, weight: .light))
                .animation(.smooth)
            Spacer()
        }
        .padding(.horizontal)
    }
}
