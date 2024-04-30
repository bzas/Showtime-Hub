//
//  MovieActorCarousel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 30/4/24.
//

import SwiftUI

struct MovieActorCarouselView: View {
    @EnvironmentObject var viewModel: MovieDetailView.ViewModel

    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            HStack {
                Text("Cast")
                    .foregroundStyle(LinearGradient.appGradient)
                    .font(.system(size: 20))
                Spacer()
            }

            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: 20) {
                    ForEach(viewModel.movieActors, id: \.self) { movieActor in
                        MovieActorCarouselCellView(movieActor: movieActor)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    MovieActorCarouselView()
}
