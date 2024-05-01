//
//  MovieDetailView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                MovieDetailHeaderView()
                    .environmentObject(viewModel)

                MovieDetailBodyView()
                    .environmentObject(viewModel)

                Spacer()
            }
        }
        .scrollIndicators(.hidden)
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
