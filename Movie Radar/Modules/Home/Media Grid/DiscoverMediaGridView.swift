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
                Text("No movies were found")
                    .padding()
                Spacer()
            }
        } else {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(viewModel.gridItems, id: \.self) { movie in
                    GridCellView(movie: movie)
                        .onAppear {
                            viewModel.continueFetchIfNeeded(lastMoviePresented: movie)
                        }
                        .onTapGesture {
                            viewModel.detailMediaToShow = movie
                        }
                        .contextMenu {
                            MediaContextMenu()
                        }
                }
            }
        }
    }
}

#Preview {
    DiscoverMediaGridView()
}
