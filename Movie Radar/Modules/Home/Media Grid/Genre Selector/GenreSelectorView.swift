//
//  GenreSelectorView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 27/4/24.
//

import SwiftUI

struct GenreSelectorView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @EnvironmentObject var viewModel: HomeGridView.ViewModel

    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(spacing: 8) {
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: 8) {
                    ForEach(viewModel.genreList.genres, id: \.self) { genre in
                        GenreSelectorCellView(genre: genre)
                            .environmentObject(viewModel)
                    }
                }
            }
            .frame(maxHeight: 30)
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal, 2)
        .padding(.bottom, 4)
        .disabled(viewModel.isSearching)
        .opacity(viewModel.isSearching ? 0.5 : 1)
        .sensoryFeedback(
            .impact(flexibility: .soft, intensity: 1),
            trigger: viewModel.selectedGenre
        )
    }
}
