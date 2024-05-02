//
//  MovieCarouselCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 26/4/24.
//

import SwiftUI

struct MovieCarouselCellView: View {
    @State var movie: Movie

    var body: some View {
        ZStack {

            ZStack {
                AsyncImage(url: movie.wideImageUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                } placeholder: {
                    PlaceholderView(type: .movie)

                }
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.width / 1.778
                )

                LinearGradient(
                    stops: [
                        Gradient.Stop(color: .clear, location: 0.6),
                        Gradient.Stop(color: UIColor.systemBackground.color, location: 1)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
            .padding(.bottom, 66)

            HStack(spacing: 8) {
                VStack {
                    Spacer()
                    AsyncImage(url: movie.posterImageUrl) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        PlaceholderView(type: .movie)
                    }
                    .frame(width: 100, height: 133)
                    .clipped()
                }

                VStack(spacing: 6) {
                    Spacer()
                        Text(movie.title ?? "")
                            .font(.system(size: 20))
                            .frame(maxWidth: 200, alignment: .leading)
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                            .shadow(color: .black, radius: 2)

                    if let releaseDate = movie.releaseDate {
                        Text("Release: " + releaseDate)
                            .font(.system(size: 12, weight: .light))
                            .frame(maxWidth: 200, alignment: .leading)
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            .padding()
        }
    }
}
