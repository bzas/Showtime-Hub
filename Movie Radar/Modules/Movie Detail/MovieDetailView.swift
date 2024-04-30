//
//  MovieDetailView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                ZStack {
                    AsyncImage(url: viewModel.movie.squareImageUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        PlaceholderView(type: .movie)
                            .aspectRatio(1, contentMode: .fill)
                    }
                    .clipped()

                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: .clear, location: 0.6),
                            Gradient.Stop(color: UIColor.systemBackground.color, location: 0.95)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )

                    VStack {
                        Spacer()
                        HStack {
                            Text(viewModel.movie.title ?? "")
                                .font(.system(size: 30, weight: .light))
                                .lineLimit(6)
                                .shadow(color: UIColor.systemBackground.color, radius: 2)
                            Spacer()
                        }
                        .padding(.trailing)
                        GenreCarouselView()
                            .environmentObject(viewModel)
                    }
                    .padding(.horizontal)
                }

                VStack(spacing: 20) {
                    Text(viewModel.movie.overview ?? "")
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 14))
                    MovieActorCarouselView()
                        .environmentObject(viewModel)
                }
                .padding(.horizontal)

                Spacer()
            }
        }
        .scrollIndicators(.hidden)
    }
}
