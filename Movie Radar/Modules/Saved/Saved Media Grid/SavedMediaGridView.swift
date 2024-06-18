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
    @Query var mediaItems: [SavedMedia]
    
    var userList: UserList
    let listColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(
        viewModel: SavedMediaView.ViewModel,
        userList: UserList
    ) {
        self.viewModel = viewModel
        self.userList = userList
        _mediaItems = Query(
            filter: viewModel.filtersPredicate(userList: userList),
            sort: \SavedMedia.detail.name
        )
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                SavedMediaListHeaderView(
                    userList: userList,
                    mediaItems: mediaItems
                )
                .environmentObject(viewModel)
                
                if mediaItems.isEmpty {
                    VStack {
                        Spacer()
                        Text("No items saved yet")
                            .shadow(radius: 2)
                            .frame(maxWidth: .infinity)
                            .frame(height: UIScreen.main.bounds.height / 2)
                        Spacer()
                    }
                } else {
                    LazyVGrid(columns: listColumns, spacing: 8) {
                        ForEach(mediaItems, id: \.self) { media in
                            GridCellView(
                                media: media.detail,
                                type: media.type,
                                cornerRadius: 10
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
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}
