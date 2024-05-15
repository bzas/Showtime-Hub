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
        VStack {
            MovieDescriptionView()
                .environmentObject(viewModel)

            MovieDirectorView()
                .environmentObject(viewModel)

            ImageCarouselView()
                .environmentObject(viewModel)

            MovieActorCarouselView()
                .environmentObject(viewModel)

            ReviewCarouselView()
                .environmentObject(viewModel)

            SimilarMoviesCarouselView()
                .environmentObject(viewModel)

            LinksCarouselView()
                .environmentObject(viewModel)
        }
        .padding(.horizontal)
    }
}

#Preview {
    MovieDetailBodyView()
}
