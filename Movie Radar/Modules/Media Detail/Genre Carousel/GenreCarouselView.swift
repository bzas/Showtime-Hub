//
//  GenreCarouselView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 28/4/24.
//

import SwiftUI

struct GenreCarouselView: View {
    @EnvironmentObject var viewModel: MediaDetailView.ViewModel

    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 8) {
                ForEach(viewModel.media.genres ?? [], id: \.self) { genre in
                    GenreCellView(genre: genre)
                }
            }
        }
        .frame(maxHeight: 30)
        .scrollIndicators(.hidden)
    }
}
