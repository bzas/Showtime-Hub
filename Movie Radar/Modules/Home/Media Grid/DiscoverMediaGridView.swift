//
//  DiscoverMediaGridView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import SwiftUI

struct DiscoverMediaGridView: View {
    @EnvironmentObject var viewModel: HomeContentView.ViewModel
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        if viewModel.gridItems.isEmpty {
            VStack {
                Text(viewModel.isLoading ? "Loading..." : "No items were found")
                    .foregroundStyle(.gray)
                    .padding()
                    .padding(.vertical)
                Spacer()
            }
            .frame(height: 500)
        } else {
            LazyVGrid(columns: columns, spacing: 8) {                
                ForEach(viewModel.gridItems, id: \.self) { media in
                    GridCellView(media: media)
                        .onAppear {
                            viewModel.continueFetchIfNeeded(lastMoviePresented: media)
                        }
                        .onTapGesture {
                            viewModel.detailMediaToShow = media
                        }
                        .contextMenu {
                            MediaContextMenu(
                                media: media,
                                mediaType: viewModel.type,
                                toastInfo: $viewModel.toastInfo
                            )
                        }
                }
            }
        }
    }
}
