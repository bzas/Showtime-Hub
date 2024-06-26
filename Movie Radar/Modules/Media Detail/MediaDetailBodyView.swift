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
            GenreCarouselView()
                .environmentObject(viewModel)
            
            MediaDescriptionView()
                .environmentObject(viewModel)

            MediaCrewView()
                .environmentObject(viewModel)
            
            ProviderCarouselView()
                .environmentObject(viewModel)

            ImageCarouselView()
                .environmentObject(viewModel)
            
            SeasonsCarouselView()
                .environmentObject(viewModel)

            ActorCarouselView()
                .environmentObject(viewModel)

            ReviewCarouselView()
                .environmentObject(viewModel)

            MediaCarouselView(
                title: NSLocalizedString("Similar", comment: ""),
                recommendationsList: $viewModel.recommendationsList,
                detailMediaToShow: $viewModel.detailMediaToShow
            )

            LinksCarouselView()
                .environmentObject(viewModel)
        }
        .padding()
    }
}
