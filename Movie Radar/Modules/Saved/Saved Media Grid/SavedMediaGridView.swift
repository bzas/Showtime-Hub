//
//  SavedMediaGridView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI
import SwiftData

struct SavedMediaGridView: View {
    @EnvironmentObject var viewModel: SavedMediaView.ViewModel
    @Query(sort: \SavedMedia.detail.popularity, order: .forward) var mediaItems: [SavedMedia]
    
    var type: SavedType
    
    let fullScreenColumns = [
        GridItem(.flexible())
    ]
    
    let listColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        let filteredItems = viewModel.items(items: mediaItems, savedType: type)

        if filteredItems.isEmpty {
            VStack {
                Text("No items saved yet")
                    .foregroundStyle(.gray)
                    .padding()
            }
        } else {
            ScrollView {
                let columns = viewModel.selectedDisplayMode == .list ? listColumns : fullScreenColumns
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(filteredItems, id: \.self) { media in
                        switch viewModel.selectedDisplayMode {
                        case .list:
                            ListGridCellView(media: media.detail)
                                .onTapGesture {
                                    viewModel.detailMediaToShow = media
                                }
                                .contextMenu {
                                    MediaContextMenu(
                                        media: media.detail,
                                        mediaType: viewModel.selectedMediaType
                                    )
                                }
                        case .fullScreen:
                            FullScreenGridCellView(media: media.detail)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SavedMediaGridView(type: .favorites)
}
