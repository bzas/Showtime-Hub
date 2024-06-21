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
            .padding(.bottom, 12)
            .padding(.top, 48)
        }
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
