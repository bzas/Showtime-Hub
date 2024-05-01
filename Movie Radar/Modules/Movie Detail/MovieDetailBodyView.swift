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
            Text(viewModel.movie.overview ?? "")
                .multilineTextAlignment(.leading)
                .font(.system(size: 14))
            MovieActorCarouselView()
                .environmentObject(viewModel)
        }
        .padding(.horizontal)
    }
}

#Preview {
    MovieDetailBodyView()
}
