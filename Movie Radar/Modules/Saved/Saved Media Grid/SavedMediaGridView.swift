//
//  SavedMediaGridView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI
import SwiftData

struct SavedMediaGridView: View {
    var viewModel: SavedMediaView.ViewModel
    
    @Query var mediaItems: [SavedMedia]
    
    var type: SavedType
    let listColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(viewModel: SavedMediaView.ViewModel, type: SavedType) {
        self.viewModel = viewModel
        self.type = type
        _mediaItems = Query(
            filter: viewModel.filtersPredicate(savedType: type),
            sort: \SavedMedia.detail.name
        )
    }
    
    var body: some View {
        GeometryReader { proxy in
            if mediaItems.isEmpty {
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
                        ForEach(mediaItems, id: \.self) { media in
                            ListGridCellView(media: media.detail)
                                .onAppear(perform: {
                                    print(media.detail.date)
                                })
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
