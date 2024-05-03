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
                    .id(0)

                MovieDetailBodyView()
                    .environmentObject(viewModel)
                    .id(1)
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
        .blur(radius: viewModel.showDetailImage ? 10 : 0)
        .overlay {
            if viewModel.showDetailImage {
                ImageDetailView(
                    viewModel: .init(
                        imageList: viewModel.imageList,
                        startingIndex: viewModel.imageIndexToShow,
                        showDetailImage: $viewModel.showDetailImage
                    )
                )
            }
        }
    }
}
