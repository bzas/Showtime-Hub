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
            HStack {
                HeaderText(text: "Discover")
                    .id("HomeHeader")

                VStack {
                    Spacer()
                    SortSelectorView()
                        .environmentObject(viewModel)
                }
            }

            SearchBar()

            GenreSelectorView()
                .environmentObject(viewModel)

            if !viewModel.discoverList.results.isEmpty {
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
