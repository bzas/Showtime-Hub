//
//  MediaCarouselView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 25/4/24.
//

import SwiftUI

struct MediaCarouselView: View {
    @EnvironmentObject var viewModel: HomeContentView.ViewModel
    let type: MediaCarouselType

    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 0) {
                let movies = viewModel.upcomingList.results
                if movies.isEmpty {
                    PlaceholderView()
                        .frame(
                            width: UIScreen.main.bounds.width,
                            height: UIScreen.main.bounds.width / 1.778
                        )
                } else {
                    ForEach(movies, id: \.self) { movie in
                        MediaCarouselCellView(movie: movie)
                            .onTapGesture {
                                viewModel.detailMediaToShow = movie
                            }
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.paging)
        .scrollIndicators(.hidden)
        .padding(.bottom)
    }
}

#Preview {
    MediaCarouselView(type: .popular)
}
