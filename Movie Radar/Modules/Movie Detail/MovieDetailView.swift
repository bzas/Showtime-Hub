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
        .sheet(isPresented: $viewModel.showDetailPerson) {
            if let detailPersonId = viewModel.detailPersonToShow?.id {
                PersonDetailView(
                    viewModel: .init(
                        apiService: viewModel.apiService,
                        personId: detailPersonId
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
