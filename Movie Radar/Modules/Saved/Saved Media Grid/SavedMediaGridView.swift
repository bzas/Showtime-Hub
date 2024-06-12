//
//  SavedMediaGridView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI
import SwiftData

struct SavedMediaGridView: View {
    @ObservedObject var viewModel: SavedMediaView.ViewModel
    
    @Binding var headerHeight: CGFloat
    @Query var mediaItems: [SavedMedia]
    
    var userList: UserList
    let listColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(
        viewModel: SavedMediaView.ViewModel,
        userList: UserList,
        headerHeight: Binding<CGFloat>
    ) {
        self.viewModel = viewModel
        self.userList = userList
        self._headerHeight = headerHeight
        _mediaItems = Query(
            filter: viewModel.filtersPredicate(userList: userList),
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
                        GridCellView(
                            media: media.detail,
                            type: media.type
                        )
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
                .padding(.vertical, headerHeight)
                .padding(.top, 6)
                .padding(.horizontal, 6)
            }
        }
    }
}
