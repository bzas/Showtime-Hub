//
//  GenreCarouselView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 28/4/24.
//

import SwiftUI

struct GenreCarouselView: View {
    @EnvironmentObject var viewModel: MovieDetailView.ViewModel

    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 8) {
                ForEach(viewModel.movie.genres ?? [], id: \.self) { genre in
                    GenreCellView(genre: genre)
                        .environmentObject(viewModel)
                }
            }
        }
        .frame(maxHeight: 30)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    GenreCarouselView()
}
