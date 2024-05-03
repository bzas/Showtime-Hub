//
//  HomeView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        ScrollView {
            VStack {
                MovieCarouselView(type: .popular)
                    .environmentObject(viewModel)

                MovieGridView()
                    .environmentObject(viewModel)
            }
        }
        .scrollIndicators(.hidden)
        .fullScreenCover(isPresented: $viewModel.showDetailMovie) {
            if let detailMovieToShow = viewModel.detailMovieToShow {
                MovieDetailView(
                    viewModel: .init(
                        apiService: viewModel.apiService,
                        movie: detailMovieToShow
                    )
                )
            }
        }
    }
}

#Preview {
    HomeView(
        viewModel: .init(
            apiService: APIServiceMock()
        )
    )
}
