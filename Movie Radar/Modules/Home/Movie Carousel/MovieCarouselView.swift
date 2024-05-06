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
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 0) {
                let movies = viewModel.upcomingList.movies
                if movies.isEmpty {
                    PlaceholderView(type: .movie)
                        .frame(
                            width: UIScreen.main.bounds.width,
                            height: UIScreen.main.bounds.width / 1.778
                        )
                } else {
                    ForEach(movies, id: \.self) { movie in
                        MovieCarouselCellView(movie: movie)
                            .onTapGesture {
                                viewModel.detailMovieToShow = movie
                            }
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.paging)
        .scrollIndicators(.hidden)
        .padding(.bottom)
    }
}

#Preview {
    MovieCarouselView(type: .popular)
}
