//
//  PersonMovieCarouselView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 6/5/24.
//

import SwiftUI

struct PersonMovieCarouselView: View {
    @EnvironmentObject var viewModel: PersonDetailView.ViewModel
    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            HStack {
                Text("Movies")
                    .foregroundStyle(LinearGradient.appGradient)
                    .font(.system(size: 20))
                Spacer()
            }

            if viewModel.movies.isEmpty {
                NoDataAvailableView(title: "No information available")
            } else {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 16) {
                        ForEach(viewModel.movies, id: \.self) { movie in
                            PersonMovieCarouselCellView(movie: movie)
                                .onTapGesture {
                                    if let movieId = movie.id {
                                        viewModel.selectedMovieToShow = Movie(id: movieId)
                                    }
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned)
            }
        }
        .padding()
    }
}

#Preview {
    PersonMovieCarouselView()
}
