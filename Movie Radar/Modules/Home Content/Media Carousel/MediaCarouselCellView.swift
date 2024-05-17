//
//  MediaCarouselCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 26/4/24.
//

import SwiftUI

struct MediaCarouselCellView: View {
    @State var movie: Media

    var body: some View {
        ZStack {
            ZStack {
                AsyncImage(url: movie.wideImageUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    PlaceholderView()
                }
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.width / 1.778
                )
                .clipped()

                LinearGradient(
                    stops: [
                        Gradient.Stop(color: .clear, location: 0.6),
                        Gradient.Stop(color: Color.black, location: 1)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
            .padding(.bottom, 66)
            .padding(.top, 8)
            .scrollTransition(.animated.threshold(.visible(0.9))) { content, phase in
                content
                    .opacity(phase.isIdentity ? 1 : 0.6)
                    .blur(radius: phase.isIdentity ? 0 : 2)
            }

            HStack(spacing: 8) {
                VStack {
                    Spacer()
                    AsyncImage(url: movie.posterImageUrl) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        PlaceholderView()
                    }
                    .frame(width: 100, height: 133)
                    .clipped()
                }

                VStack(spacing: 6) {
                    Spacer()
                        Text(movie.publicName)
                            .font(.system(size: 20))
                            .frame(maxWidth: 200, alignment: .leading)
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                            .shadow(radius: 2)

                    if let releaseDate = movie.date {
                        HStack(spacing: 0) {
                            Text("Release ")
                                .fontWeight(.bold)
                            Text(releaseDate)
                        }
                        .font(.system(size: 12, weight: .light))
                        .frame(maxWidth: 200, alignment: .leading)
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            .padding()
            .scrollTransition(.animated.threshold(.visible(0.6))) { content, phase in
                content
                    .opacity(phase.isIdentity ? 1 : 0.4)
                    .scaleEffect(phase.isIdentity ? 1 : 0.9)
                    .blur(radius: phase.isIdentity ? 0 : 2)
            }
        }
    }
}
