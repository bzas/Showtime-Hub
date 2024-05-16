//
//  MediaDetailBodyView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import SwiftUI

struct MediaDetailBodyView: View {
    @EnvironmentObject var viewModel: MediaDetailView.ViewModel

    var body: some View {
        VStack {
            MediaDescriptionView()
                .environmentObject(viewModel)

            MovieDirectorView()
                .environmentObject(viewModel)

            ImageCarouselView()
                .environmentObject(viewModel)

            ActorCarouselView()
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
    MediaDetailBodyView()
}
