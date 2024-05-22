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
    
    @Query(sort: [
        SortDescriptor(\SavedMedia.detail.name)
    ]) var mediaItems: [SavedMedia]
    
    var type: SavedType
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
                    LazyVGrid(columns: listColumns, spacing: 8) {
                        ForEach(filteredItems, id: \.self) { media in
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
                        }
                    }
                    .padding(.top, 147)
                }
                .ignoresSafeArea()
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    SavedMediaGridView(type: .favorites)
}
