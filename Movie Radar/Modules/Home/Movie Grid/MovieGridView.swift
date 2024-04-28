//
//  MovieGridView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 27/4/24.
//

import SwiftUI

struct MovieGridView: View {
    @EnvironmentObject var viewModel: HomeView.ViewModel

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            GenreSelectorView()
                .environmentObject(viewModel)

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
            .padding(.horizontal, 6)
        }
    }
}

#Preview {
    MovieGridView()
}
