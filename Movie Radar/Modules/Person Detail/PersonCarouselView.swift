//
//  PersonCarouselView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 6/5/24.
//

import SwiftUI

struct PersonCarouselView: View {
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
                NoDataAvailableView(title: "No information available")
            } else {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 16) {
                        ForEach(mediaList, id: \.self) { movie in
                            PersonCarouselCellView(movie: movie)
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

#Preview {
    PersonCarouselView(type: .movie)
}
