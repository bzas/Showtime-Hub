//
//  HomeContentView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI

struct HomeContentView: View {
    @Binding var headerHeight: CGFloat
    @StateObject var viewModel: ViewModel

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack {
                    if viewModel.type == .movie {                        
                        MediaCarouselView(type: .popular)
                            .environmentObject(viewModel)
                    }

                    GridView()
                        .environmentObject(viewModel)
                }
                .padding(.vertical, headerHeight)
            }
            .scrollIndicators(.hidden)
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
}
