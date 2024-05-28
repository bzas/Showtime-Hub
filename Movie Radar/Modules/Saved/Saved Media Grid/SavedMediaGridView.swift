//
//  SavedMediaGridView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI
import SwiftData

struct SavedMediaGridView: View {
    @State var viewModel: SavedMediaView.ViewModel
    
    var headerHeight: Binding<CGFloat>
    @Query var mediaItems: [SavedMedia]
    
    var type: SavedType
    let listColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(viewModel: SavedMediaView.ViewModel, type: SavedType, headerHeight: Binding<CGFloat>) {
        self.viewModel = viewModel
        self.type = type
        self.headerHeight = headerHeight
        _mediaItems = Query(
            filter: viewModel.filtersPredicate(savedType: type),
            sort: \SavedMedia.detail.name
        )
    }
    
    var body: some View {
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
                            .onTapGesture {
                                viewModel.detailMediaToShow = media
                            }
                            .contextMenu {
                                MediaContextMenu(
                                    media: media.detail,
                                    mediaType: media.type, 
                                    toastInfo: $viewModel.toastInfo
                                )
                            }
                    }
                }
                .padding(.vertical, headerHeight.wrappedValue)
            }
            .scrollIndicators(.hidden)
        }
    }
}
