//
//  GridView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 27/4/24.
//

import SwiftUI

struct GridView: View {
    @EnvironmentObject var viewModel: HomeContentView.ViewModel

    var body: some View {
        VStack {
            HStack {
                Spacer()

                VStack {
                    Spacer()
                    SortSelectorView()
                        .environmentObject(viewModel)
                }
            }
            .id("HomeHeader")

            SearchBar()

            GenreSelectorView()
                .environmentObject(viewModel)

            if !viewModel.discoverList.results.isEmpty {
                DiscoverMediaGridView()
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
    GridView()
}
