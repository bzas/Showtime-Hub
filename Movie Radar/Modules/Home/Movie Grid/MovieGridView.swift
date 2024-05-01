//
//  MovieGridView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 27/4/24.
//

import SwiftUI

struct MovieGridView: View {
    @EnvironmentObject var viewModel: HomeView.ViewModel

    var body: some View {
        VStack {
            HeaderText(text: "Discover")
            GenreSelectorView()
                .environmentObject(viewModel)
            if !viewModel.discoverList.movies.isEmpty {
                DiscoverMoviesGridView()
                    .environmentObject(viewModel)
            } else {
                GridPlaceholderView()
            }
        }
        .padding(.horizontal, 6)
        .padding(.bottom, 48)
    }
}

#Preview {
    MovieGridView()
}
