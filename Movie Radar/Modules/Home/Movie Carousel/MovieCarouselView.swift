//
//  MovieCarouselView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 25/4/24.
//

import SwiftUI

struct MovieCarouselView: View {
    @EnvironmentObject var viewModel: HomeView.ViewModel

    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(spacing: 8) {
            HeaderText(text: "Popular movies")
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: 8) {
                    ForEach(viewModel.popularList.movies, id: \.self) { movie in
                        MovieCarouselCellView(movie: movie)
                            .onTapGesture {
                                viewModel.detailMovieToShow = movie
                        }
                    }
                }
                .frame(height: 200)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal)
    }
}

#Preview {
    MovieCarouselView()
}
