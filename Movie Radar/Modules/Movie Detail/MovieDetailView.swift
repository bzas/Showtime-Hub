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
            VStack {
                ZStack {
                    AsyncImage(url: viewModel.movie.wideImageUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        PlaceholderView(type: .movie)
                            .frame(height: 220)
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
                        GenreCarouselView()
                            .padding(6)
                            .environmentObject(viewModel)
                    }
                }

                VStack(spacing: 20) {
                    VStack(spacing: 10) {
                        HStack {
                            Text(viewModel.movie.title ?? "")
                                .font(.system(size: 25, weight: .light))
                                .lineLimit(3)
                            Spacer()
                        }

                        Text(viewModel.movie.overview ?? "")
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 14))
                    }

                    MovieActorCarouselView()
                        .environmentObject(viewModel)
                }
                .padding(.horizontal)

                Spacer()
            }
        }
        .scrollIndicators(.hidden)
        .presentationDetents([.medium, .large])
    }
}
