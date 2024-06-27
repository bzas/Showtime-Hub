//
//  DiscoverMediaGridView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import SwiftUI

struct DiscoverMediaGridView: View {
    @EnvironmentObject var viewModel: HomeGridView.ViewModel
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let iPadColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        if viewModel.gridItems.isEmpty {
            if !viewModel.isLoading {
                Text("No items were found")
                    .foregroundStyle(.gray)
                    .frame(height: 500)
            }
        } else {
            LazyVGrid(columns: UIDevice.isIPad ? iPadColumns : columns, spacing: 8) {
                ForEach(viewModel.gridItems, id: \.self) { media in
                    GridCellView(
                        media: media,
                        type: viewModel.type
                    )
                    .onTapGesture {
                        viewModel.detailMediaToShow = media
                    }
                    .contextMenu {
                        MediaContextMenu(
                            apiService: viewModel.apiService,
                            media: media,
                            mediaType: viewModel.type,
                            toastInfo: $viewModel.toastInfo
                        )
                    }
                }
                
                Color.clear
                    .frame(
                        width: 0,
                        height: 0,
                        alignment: .bottom
                    )
                    .onAppear {
                        Task {
                            await viewModel.continueFetchIfNeeded()
                        }
                    }
            }
        }
    }
}
