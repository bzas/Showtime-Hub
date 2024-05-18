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

            if viewModel.type.isMovie {
                MediaCrewView(type: .movie)
                    .environmentObject(viewModel)
            } else {
                MediaCrewView(type: .tv)
                    .environmentObject(viewModel)
            }

            ImageCarouselView()
                .environmentObject(viewModel)
            
            SeasonsCarouselView()
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
