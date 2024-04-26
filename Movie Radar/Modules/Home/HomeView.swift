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
        VStack {
            MovieCarouselView()
                .environmentObject(viewModel)
            Spacer()
        }
        .sheet(isPresented: $viewModel.showDetailMovie) {
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
