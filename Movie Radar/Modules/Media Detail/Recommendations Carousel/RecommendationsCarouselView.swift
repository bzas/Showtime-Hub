//
//  SimilarMoviesCarousel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import SwiftUI

struct SimilarMoviesCarouselView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @EnvironmentObject var viewModel: MediaDetailView.ViewModel
    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            HStack {
                Text("Similar")
                    .foregroundStyle(appGradient.value)
                    .font(.system(size: 20))
                Spacer()
            }

            if viewModel.recommendationsList.results.isEmpty {
                NoDataAvailableView(title: NSLocalizedString("No recommendations available", comment: ""))
            } else {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 16) {
                        ForEach(viewModel.recommendationsList.results, id: \.self) { movie in
                            RecommendationsCarouselCellView(movie: movie)
                                .onTapGesture {
                                    viewModel.detailMediaToShow = movie
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
