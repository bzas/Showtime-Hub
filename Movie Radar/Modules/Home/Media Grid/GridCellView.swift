//
//  GridCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 27/4/24.
//

import SwiftUI

struct GridCellView: View {
    @State var media: Media

    var body: some View {
        ZStack {
            AsyncImage(url: media.posterImageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .clipped()
            } placeholder: {
                PlaceholderView()
                    .aspectRatio(0.6666666667, contentMode: .fill)
            }
            .clipped()
            
            LinearGradient(
                stops: [
                    .init(color: .black.opacity(0.5), location: 0),
                    .init(color: .clear, location: 0.2)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .overlay {
            VStack {
                HStack {
                    Text(media.name)
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                        .shadow(radius: 1)
                        .padding(6)
                    Spacer()
                }
                Spacer()
            }
        }
        .scrollTransition(.animated.threshold(.visible(0.3))) { content, phase in
            content
                .opacity(phase.isIdentity ? 1 : 0.6)
                .blur(radius: phase.isIdentity ? 0 : 2)
        }
    }
}
