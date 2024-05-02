//
//  MovieScoreView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 2/5/24.
//

import SwiftUI

struct MovieDescriptionView: View {
    @EnvironmentObject var viewModel: MovieDetailView.ViewModel

    var body: some View {
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
        .padding(.bottom)
    }
}

#Preview {
    MovieDescriptionView()
}
