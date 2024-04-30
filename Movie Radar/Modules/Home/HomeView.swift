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

        ScrollView(.init()) {
            ZStack {
                GeometryReader { proxy in
                    TabView {
                        MovieCarouselStackView()
                            .environmentObject(viewModel)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .frame(width: proxy.size.width, height: proxy.size.height)
                            .rotationEffect(.degrees(-90))

                        MovieGridView()
                            .environmentObject(viewModel)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .frame(width: proxy.size.width, height: proxy.size.height)
                            .rotationEffect(.degrees(-90))
                    }
                    .frame(width: proxy.size.height, height: proxy.size.width)
                    .rotationEffect(.degrees(90), anchor: .topLeading)
                    .offset(x: proxy.size.width)
                }
                .tabViewStyle(
                    PageTabViewStyle(indexDisplayMode: .never)
                )
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
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

        /*
        TabView {
            MovieCarouselStackView()
                .environmentObject(viewModel)
            
            MovieGridView()
                .environmentObject(viewModel)
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
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
         */
    }
}

#Preview {
    HomeView(
        viewModel: .init(
            apiService: APIServiceMock()
        )
    )
}
