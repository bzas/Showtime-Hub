//
//  HomeGridView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 27/4/24.
//

import SwiftUI

struct HomeGridView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                DiscoverHeaderView(
                    media: viewModel.discoverList.results.first,
                    detailMediaToShow: $viewModel.detailMediaToShow
                )

                VStack {
                    SortSelectorView()
                        .environmentObject(viewModel)

                    GenreSelectorView()
                        .environmentObject(viewModel)

                    DiscoverMediaGridView()
                        .environmentObject(viewModel)
                    
                    ProgressView()
                        .frame(height: 75)
                }
                .padding(.horizontal, 6)
                .background(.black)

            }
            .padding(.bottom, 12)
            .background(.black)
        }
        .ignoresSafeArea(edges: .top)
        .fullScreenCover(isPresented: $viewModel.showDetailMedia) {
            if let detailMediaToShow = viewModel.detailMediaToShow {
                MediaDetailView(
                    viewModel: .init(
                        apiService: viewModel.apiService,
                        media: detailMediaToShow,
                        type: viewModel.type
                    )
                )
            }
        }
        .toast(
            show: $viewModel.showToast,
            toastInfo: viewModel.toastInfo
        )
    }
}
