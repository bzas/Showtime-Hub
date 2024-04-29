//
//  MovieCarouselView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 25/4/24.
//

import SwiftUI

struct MovieCarouselView: View {
    @EnvironmentObject var viewModel: HomeView.ViewModel
    let type: MovieCarouselType

    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(spacing: 8) {
            HeaderText(text: type.title)
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: 8) {
                    let movies = viewModel.getMovieList(type: type)
                    if movies.isEmpty {
                        CarouselPlaceholderView()
                    } else {
                        ForEach(movies, id: \.self) { movie in
                            MovieCarouselCellView(movie: movie)
                                .onTapGesture {
                                    viewModel.detailMovieToShow = movie
                                }
                        }
                    }
                }
                .frame(height: 200)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal, 6)
    }
}

#Preview {
    MovieCarouselView(type: .popular)
}
