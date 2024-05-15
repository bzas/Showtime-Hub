//
//  HomeMoviesView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI

struct HomeMoviesView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        ScrollViewReader { proxy in
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
            .onChange(of: viewModel.isSearching) {
                if viewModel.isSearching {
                    withAnimation {
                        proxy.scrollTo("HomeHeader", anchor: .top)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeMoviesView(
        viewModel: .init(
            apiService: APIServiceMock()
        )
    )
}
