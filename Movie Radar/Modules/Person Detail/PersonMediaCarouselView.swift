//
//  PersonMediaCarouselView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 6/5/24.
//

import SwiftUI

struct PersonMediaCarouselView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @EnvironmentObject var viewModel: PersonDetailView.ViewModel
    let type: MediaType
    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            HStack {
                Text(type.title)
                    .foregroundStyle(appGradient.value)
                    .font(.system(size: 20))
                Spacer()
            }

            let mediaList = type.isMovie ? viewModel.movies : viewModel.series
            if mediaList.isEmpty {
                NoDataAvailableView(title: NSLocalizedString("No information available", comment: ""))
            } else {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 16) {
                        ForEach(mediaList, id: \.self) { movie in
                            PersonMediaCarouselCellView(movie: movie)
                                .onTapGesture {
                                    if let movieId = movie.id {
                                        viewModel.selectedMediaToShow = Media(id: movieId)
                                    }
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned)
            }
        }
        .padding()
    }
}
