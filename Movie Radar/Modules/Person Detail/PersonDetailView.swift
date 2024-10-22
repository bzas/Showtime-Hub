//
//  PersonDetailView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 5/5/24.
//

import SwiftUI

struct PersonDetailView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        if viewModel.detailLoaded,
           viewModel.person == nil {
            Text("No profile data")
                .presentationDetents([.medium])
        } else {
            GeometryReader { proxy in
                ScrollView {
                    VStack(spacing: 8) {
                        PersonHeaderView(proxy: proxy)
                            .environmentObject(viewModel)

                        if let biography = viewModel.person?.biography {
                            Text(biography)
                                .font(.system(size: 14, weight: .light))
                                .padding()
                        }

                        PersonMediaCarouselView(type: .movie)
                            .environmentObject(viewModel)
                        
                        PersonMediaCarouselView(type: .tv)
                            .environmentObject(viewModel)
                    }
                }
                .scrollIndicators(.hidden)
            }
            .fullScreenCover(isPresented: $viewModel.showDetailMedia) {
                if let selectedMediaToShow = viewModel.selectedMediaToShow {
                    MediaDetailView(
                        viewModel: .init(
                            apiService: viewModel.apiService,
                            media: selectedMediaToShow,
                            type: .movie
                        )
                    )
                }
            }
        }
    }
}
