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

    var body: some View {
        let filteredItemsCount = viewModel.items(
            items: mediaItems,
            savedType: selectedTab == 0 ? .favorites : .viewed
        ).count
        
        HStack {
            Text("\(filteredItemsCount) items saved")
                .font(.system(size: 14, weight: .light))
                .animation(.smooth)
            Spacer()
        }
        .padding(.horizontal)
    }
}
