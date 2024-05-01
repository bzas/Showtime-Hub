//
//  DiscoverMoviesGridView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import SwiftUI

struct DiscoverMoviesGridView: View {
    @EnvironmentObject var viewModel: HomeView.ViewModel
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(viewModel.discoverList.movies, id: \.self) { movie in
                MovieGridCellView(movie: movie)
                    .onAppear {
                        viewModel.continueFetchIfNeeded(lastMoviePresented: movie)
                    }
                    .onTapGesture {
                        viewModel.detailMovieToShow = movie
                    }
            }
        }
    }
}

#Preview {
    DiscoverMoviesGridView()
}
