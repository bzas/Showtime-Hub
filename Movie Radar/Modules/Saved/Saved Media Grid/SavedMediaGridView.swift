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
        
        GeometryReader { proxy in
            
            if filteredItems.isEmpty {
                VStack {
                    Spacer()
                    Text("No items saved yet")
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
            } else {
                ScrollView {
                    let columns = viewModel.selectedDisplayMode == .list ? listColumns : fullScreenColumns
                    let spacing = viewModel.selectedDisplayMode == .list ? 8.0 : 0.0
                    LazyVGrid(columns: columns, spacing: spacing) {
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
                                            mediaType: media.type
                                        )
                                    }
                            case .fullScreen:
                                FullScreenGridCellView(
                                    media: media,
                                    proxy: proxy
                                )
                                .environmentObject(viewModel)
                            }
                        }
                    }
                    .if(viewModel.selectedDisplayMode == .fullScreen) {
                        $0.scrollTargetLayout()
                    }
                }
                .scrollIndicators(.hidden)
                .if(viewModel.selectedDisplayMode == .fullScreen) {
                    $0.scrollTargetBehavior(.paging)
                }
            }
        }
    }
}

#Preview {
    SavedMediaGridView(type: .favorites)
}
