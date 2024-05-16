//
//  SimilarMoviesCarousel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import SwiftUI

struct SimilarMoviesCarouselView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .bluePurple
    @EnvironmentObject var viewModel: MediaDetailView.ViewModel
    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            HStack {
                Text("Similar movies")
                    .foregroundStyle(appGradient.value)
                    .font(.system(size: 20))
                Spacer()
            }

            if viewModel.movieRecommendationsList.results.isEmpty {
                NoDataAvailableView(title: "No recommendations available")
            } else {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 16) {
                        ForEach(viewModel.movieRecommendationsList.results, id: \.self) { movie in
                            RecommendationsCarouselCellView(movie: movie)
                                .onTapGesture {
                                    viewModel.detailMovieToShow = movie
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
            }
        }
    }
}

#Preview {
    SimilarMoviesCarouselView()
}
