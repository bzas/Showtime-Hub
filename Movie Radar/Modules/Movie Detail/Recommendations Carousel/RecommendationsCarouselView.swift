//
//  SimilarMoviesCarousel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import SwiftUI

struct SimilarMoviesCarouselView: View {
    @EnvironmentObject var viewModel: MovieDetailView.ViewModel
    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            HStack {
                Text("Similar movies")
                    .foregroundStyle(LinearGradient.appGradient)
                    .font(.system(size: 20))
                Spacer()
            }

            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: 8) {
                    ForEach(viewModel.movieRecommendationsList.movies, id: \.self) { movie in
                        RecommendationsCarouselCellView(movie: movie)
                            .onTapGesture {
                                viewModel.detailMovieToShow = movie
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    SimilarMoviesCarouselView()
}
