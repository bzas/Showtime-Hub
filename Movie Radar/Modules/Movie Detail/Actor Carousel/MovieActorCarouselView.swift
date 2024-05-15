//
//  MovieActorCarousel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 30/4/24.
//

import SwiftUI

struct MovieActorCarouselView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .bluePurple
    @EnvironmentObject var viewModel: MovieDetailView.ViewModel

    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            HStack {
                Text("Cast")
                    .foregroundStyle(appGradient.value)
                    .font(.system(size: 20))
                Spacer()
            }

            if viewModel.movieActors.isEmpty {
                NoDataAvailableView(title: "No cast info available")
            } else {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 20) {
                        ForEach(viewModel.movieActors, id: \.self) { movieActor in
                            MovieActorCarouselCellView(movieActor: movieActor)
                                .onTapGesture {
                                    viewModel.detailPersonToShow = movieActor
                                }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    MovieActorCarouselView()
}
