//
//  MovieCarouselStackView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 29/4/24.
//

import SwiftUI

struct MovieCarouselStackView: View {
    @EnvironmentObject var viewModel: HomeView.ViewModel

    var body: some View {
        VStack(spacing: 0) {
            MovieCarouselView(type: .popular)
                .environmentObject(viewModel)

            MovieCarouselView(type: .upcoming)
                .environmentObject(viewModel)

            MovieCarouselView(type: .topRated)
                .environmentObject(viewModel)

            Spacer()
        }
    }
}

#Preview {
    MovieCarouselStackView()
}
