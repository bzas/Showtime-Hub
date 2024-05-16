//
//  HomeContentView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI

struct HomeContentView: View {
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
    HomeContentView(
        viewModel: .init(
            apiService: APIServiceMock(),
            type: .movie
        )
    )
}
