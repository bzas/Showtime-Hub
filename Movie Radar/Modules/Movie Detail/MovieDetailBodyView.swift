//
//  MovieDetailBodyView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import SwiftUI

struct MovieDetailBodyView: View {
    @EnvironmentObject var viewModel: MovieDetailView.ViewModel

    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 12) {
                if let voteAverage = viewModel.movie.voteAverage {
                    HStack {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                        Text(String(format: "%.1f / 10", voteAverage))
                            .font(.system(size: 15))
                        Spacer()
                    }
                    .foregroundStyle(.yellow)
                }

                Text(viewModel.movie.overview ?? "")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 14))
            }

            VStack {
                MovieActorCarouselView()
                    .environmentObject(viewModel)

                ReviewCarouselView()
                    .environmentObject(viewModel)

                SimilarMoviesCarouselView()
                    .environmentObject(viewModel)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    MovieDetailBodyView()
}
