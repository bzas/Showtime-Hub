//
//  MediaCarouselCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 26/4/24.
//

import SwiftUI

struct MediaCarouselCellView: View {
    @State var media: Media
    
    var body: some View {
        ZStack {
            AsyncImage(url: media.wideImageUrl) { image in
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
        .scrollTransition(.animated.threshold(.visible(0.9))) { content, phase in
            content
                .opacity(phase.isIdentity ? 1 : 0.6)
                .blur(radius: phase.isIdentity ? 0 : 2)
        }
        .overlay {
            HStack(spacing: 8) {
                VStack {
                    Spacer()
                    AsyncImage(url: media.posterImageUrl) { image in
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
                    HStack {
                        Text(media.name)
                            .font(.system(size: 20))
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                            .shadow(radius: 2)
                        Spacer()
                    }
                    
                    if let releaseDate = media.dateString {
                        HStack {
                            Text(releaseDate)
                                .font(.system(size: 12, weight: .light))
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            .padding()
        }
    }
}
