//
//  MovieGridView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 27/4/24.
//

import SwiftUI

struct MovieGridView: View {
    @EnvironmentObject var viewModel: HomeView.ViewModel

    let rows = [
        GridItem(.fixed(200)),
        GridItem(.fixed(200))
    ]

    var body: some View {
        VStack {
            HeaderText(text: "All")
            GenreSelectorView()
                .environmentObject(viewModel)
            if !viewModel.discoverList.movies.isEmpty {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 8) {
                        ForEach(viewModel.discoverList.movies, id: \.self) { movie in
                            MovieGridCellView(movie: movie)
                                .frame(width: 150, height: 200)
                                .onAppear {
                                    viewModel.continueFetchIfNeeded(lastMoviePresented: movie)
                                }
                                .onTapGesture {
                                    viewModel.detailMovieToShow = movie
                                }
                        }
                    }
                    .padding(.vertical, 6)
                }
                .padding(.horizontal, 6)
            } else {
                GridPlaceholderView()
            }
            Spacer()
        }
    }
}

#Preview {
    MovieGridView()
}
